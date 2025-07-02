wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install -y vault

mkdir /tmp/vault-data
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 \
    -nodes -keyout /tmp/vault-key.pem -out /tmp/vault-cert.pem \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

sudo tee /tmp/vault-server.hcl <<EOF
api_addr                = "https://0.0.0.1:8200"
cluster_addr            = "https://0.0.0.1:8201"
cluster_name            = "learn-vault-cluster"
disable_mlock           = true
ui                      = true

listener "tcp" {
address       = "0.0.0.1:8200"
tls_cert_file = "/tmp/vault-cert.pem"
tls_key_file  = "/tmp/vault-key.pem"
}

backend "raft" {
path    = "/tmp/vault-data"
node_id = "learn-vault-server"
}
EOF

# run vault server
nohup vault server -config=/tmp/vault-server.hcl &
vault -autocomplete-install
export VAULT_ADDR=https://127.0.0.1:8200
export VAULT_SKIP_VERIFY=true
source ~/.bashrc


vault operator init -key-shares=1 -key-threshold=1 > /tmp/vault-init.txt
key1=$(grep 'Unseal Key 1' /tmp/vault-init.txt | awk '{print $NF}')
key2=$(grep 'Unseal Key 2' /tmp/vault-init.txt | awk '{print $NF}')



vault operator unseal "$key1"
vault operator unseal "$key2"
vault status
