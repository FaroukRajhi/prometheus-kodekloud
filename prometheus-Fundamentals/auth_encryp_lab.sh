#!/bin/bash
apt update
apt install apache2-utils -y

# Generate password hash:

htpasswd -nBC 10 "" | tr -d ':\n'; echo



# It will ask for the password twice as below (enter password secret-password twice):


New password: 
Re-type new password: 



# Finally, you will get a hashed value of your password.


# Edit /etc/node_exporter/config.yml file:


vi /etc/node_exporter/config.yml



# Add below lines in it:


basic_auth_users:
  prometheus: <hashed-password>



# Restart node_exporter service


systemctl restart node_exporter
exit



# You can verify the changes using curl command:

curl http://node01:9100/metrics

# or
curl -u prometheus:secret-password http://node01:9100/metrics

# Now, let's configure the Prometheus server to use authentication when scraping metrics from node servers.

# Edit the Prometheus configuration file


vi /etc/prometheus/prometheus.yml



# Under - job_name: "nodes" add below lines:


basic_auth:
  username: prometheus
  password: secret-password



# Restart prometheus service:


systemctl restart prometheus

# SSL Encryption

#  Configure node exporter to use TLS on both nodes i.e node01 and node02. You can generate a certificate and key using the below command:
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node_exporter.key -out node_exporter.crt -subj "/C=US/ST=California/L=Oakland/O=MyOrg/CN=localhost" -addext "subjectAltName = DNS:localhost"

#Move the crt and key file under /etc/node_exporter/ directory

mv node_exporter.crt node_exporter.key /etc/node_exporter/



#Change ownership:


chown nodeusr.nodeusr /etc/node_exporter/node_exporter.key
chown nodeusr.nodeusr /etc/node_exporter/node_exporter.crt



#Edit /etc/node_exporter/config.yml file:


vi /etc/node_exporter/config.yml



#Add below lines in this file:


tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key



#Restart node exporter service:


systemctl restart node_exporter
exit



#You can verify your changes using curl command:


curl -u prometheus:secret-password -k https://node01:9100/metrics

# Let's configure Prometheus server to use HTTPS for scraping the node_exporter
#Copy the certificate from node01 to Prometheus server


scp root@node01:/etc/node_exporter/node_exporter.crt /etc/prometheus/node_exporter.crt



#Change certificate file ownership:


chown prometheus.prometheus /etc/prometheus/node_exporter.crt



# Edit /etc/prometheus/prometheus.yml file


vi /etc/prometheus/prometheus.yml 



#Add below given lines under - job_name: "nodes"


    # scheme: https
    # tls_config:
    #   ca_file: /etc/prometheus/node_exporter.crt
    #   insecure_skip_verify: true



# Restart prometheus service

systemctl restart prometheus