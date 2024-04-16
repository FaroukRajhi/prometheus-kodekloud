# The alert manager is running on the prometheus-server itself. Update the alert manager configuration i.e /etc/alertmanager/alertmanager.yml to make the following changes:



   (a) Add the following smtp configs in the global section (add new if doesn't exist), so that all notifiers can use these settings:


         smtp_smarthost: 'localhost:25'

         smtp_from: 'alertmanager@prometheus-server.com'


   (b) Under the default route, update the receiver value to general-email.


   (c) Configure a route that matches a label team: global-infra


         (i) Receiver should be set to global-infra-email


   (d) Configure another route that matches a label team: internal-infra


          (i) Receiver should be internal-infra-email


   (e) Configure global-infra-email receiver:


         (i) Set email_configs with below given two properties:


             to: root@prometheus-server.com

             require_tls: false


   (f) Configure internal-infra-email receiver:


         (i) Set email_configs with below given two properties:


             to: admin@prometheus-server.com

             require_tls: false


   (g) Configure a general-email receiver:


         (i) Set email_configs with below given two properties:


             to: admin@prometheus-server.com

             require_tls: false

Edit /etc/alertmanager/alertmanager.yml file:


vi /etc/alertmanager/alertmanager.yml



Update the file so that it looks like as below:


global:
  smtp_smarthost: 'localhost:25'
  smtp_from: 'alertmanager@prometheus-server.com'

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 2m
  repeat_interval: 1h
  receiver: 'general-email'
  routes:
    - match:
        team: global-infra
      receiver: global-infra-email
    - match:
        team: internal-infra
      receiver: internal-infra-email

receivers:
  - name: 'web.hook'
    webhook_configs:
      - url: 'http://127.0.0.1:5001/'
  - name: global-infra-email
    email_configs:
      - to: "root@prometheus-server.com"
        require_tls: false
  - name: internal-infra-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false
  - name: general-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false



Restart the alertmanager service:


systemctl restart alertmanager

