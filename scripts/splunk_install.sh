
sudo wget -O splunk-9.4.3-237ebbd22314-linux-amd64.tgz "https://download.splunk.com/products/splunk/releases/9.4.3/linux/splunk-9.4.3-237ebbd22314-linux-amd64.tgz"
sudo tar xvzf splunk-9.4.3-237ebbd22314-linux-amd64.tgz -C /opt/

sudo tee /opt/splunk/etc/system/local/user-seed.conf > /dev/null <<EOF
[user_info]
USERNAME = admin
PASSWORD = admin@123
EOF

export SPLUNK_HOME=/opt/splunk/
export PATH=$SPLUNK_HOME/bin:$PATH

cd /opt/splunk/bin
sudo ./splunk start --accept-license --answer-yes --no-prompt


