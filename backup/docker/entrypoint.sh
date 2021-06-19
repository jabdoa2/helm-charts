#!/bin/ash

# allow root login
sed -i -e 's/^root:!:/root::/' /etc/shadow

# copy keys
cp /keys/ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub
echo "" >> /etc/ssh/ssh_host_ed25519_key.pub
cp /keys/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
echo "" >> /etc/ssh/ssh_host_ed25519_key
chmod 0600 /etc/ssh/ssh_host_ed25519_key
chmod 0644 /etc/ssh/ssh_host_ed25519_key.pub

# create backup script
echo "mysqldump --lock-tables -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASS} --port ${MYSQL_PORT} --default-character-set=utf8mb4 --all-databases | gzip > /data/database_dump.sql.gz" > /root/backup-mysql.sh
chmod +x /root/backup-mysql.sh

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
