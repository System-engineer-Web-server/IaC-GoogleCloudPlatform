sudo apt update 

sudo apt-get install -y postgresql postgresql-contrib

sudo -u postgres psql -c "create user web_admin with password 'admin@123';"
echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/13/main/postgresql.conf

sudo tee -a /etc/postgresql/13/main/pg_hba.conf << EOF
host    all         web_admin          0.0.0.0/0         md5
EOF

while ! echo > /dev/tcp/10.0.1.2/5432; do
    echo "Waiting for PostgreSQL to be ready..."
    sleep 2
done

# master-salve install 
#
slot_name=$(hostname | tr -cd 'a-z0-9_')
sudo systemctl stop postgresql
sudo cp -R /var/lib/postgresql/13/main /var/lib/postgresql/13/back_up 

sudo -u postgres bash -c 'rm -rf /var/lib/postgresql/13/main/*'
sudo -u postgres bash -c "PGPASSWORD='slave@123' pg_basebackup -h 10.0.1.2 \
  -D /var/lib/postgresql/13/main -U slave -P -v -R -X stream -C -S $slot_name"
sudo systemctl start postgresql
