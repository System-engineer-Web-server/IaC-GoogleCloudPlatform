sudo apt update -y
sudo apt install -y haproxy

while ! echo > /dev/tcp/10.0.2.2/80; do
    echo "Waiting for web 1 on port 80..."
    sleep 2
done

while ! echo > /dev/tcp/10.0.2.3/80; do
    echo "Waiting for web 1 on port 80..."
    sleep 2
done

sudo tee -a /etc/haproxy/haproxy.cfg <<EOF
listen stats
    bind *:8404
    stats enable
    stats uri /stats
    stats auth admin:admin

frontend httpd-in
    bind *:80
    default_backend webserver

backend webserver
    balance roundrobin
    server web1 10.0.2.2:80 check
    server web2 10.0.2.3:80 check
EOF

sudo systemctl restart haproxy
