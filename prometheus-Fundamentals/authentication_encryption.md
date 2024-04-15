Authentication and encryption between prometheus server and your targets.
Encrypt data in transient using https protocol(SSL)
Create key and got to node exporter config path "config yaml"
tls_server_config:
  cert_file:path/ example.crt
  key_file: path/example.key
Do the same thing on prometheus
copy the node exporter crt to prometheus server

go to prometheus configuration
change the scheme to https
add
tls_config
  ca_file: /path/example.crt
  insecure_skip_verify: true
# Hashing

you can use the apache2-utils ot httpd-tools to generate a hash
htpasswd -nBC 12 "" | tr -d ':\n'
Once you have the hash you can go to your node exporter config file
basic_auth_users:
  prometheus: hashed password