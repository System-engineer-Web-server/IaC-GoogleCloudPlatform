sudo apt update 

sudo apt-get install -y postgresql postgresql-contrib
sudo -u postgres psql -c "create user slave with replication login password 'slave@123';"

echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/13/main/postgresql.conf

sudo tee -a /etc/postgresql/13/main/pg_hba.conf << EOF
host    replication     slave          10.0.1.0/24         md5
EOF
sudo systemctl restart postgresql
# sudo -i -u postgres psql postgres -c "SELECT * FROM pg_replication_slots;"
