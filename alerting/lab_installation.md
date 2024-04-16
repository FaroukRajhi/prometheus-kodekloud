Create an alert in Prometheus to check the low disk space on nodes (node01 and node02). Find more details below:



   (a) Create a rules.yaml file under /etc/prometheus/ directory.


   (b) Group name should be node


   (c) Alert name should be LowDiskSpace


   (d) The expression should calculate when any filesystem has less than 10% free space.

       [1] 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"} < 10


   (e) It should have two labels

       (1) severity: warning

       (2) environment: prod


   (f) Also update the /etc/prometheus/prometheus.yml config file to use the rules file


   (g) Finally, restart the Prometheus service.


   vi /etc/prometheus/rules.yaml
groups:
  - name: node
    rules:
      - alert: LowDiskSpace
        expr: 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"} < 10
        labels:
          severity: warning
          environment: prod