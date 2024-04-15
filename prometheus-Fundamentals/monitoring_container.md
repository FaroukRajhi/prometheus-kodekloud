Create/edit /etc/docker/daemon.json file:


vi /etc/docker/daemon.json



Add below given lines in it:


{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}



Restart docker service:


systemctl restart docker



Verify if docker is exporting the metrics now:


curl localhost:9323/metrics

# Create a new job in Prometheus called docker and add the Docker host (i.e. localhost) as a target. Make sure to restart the Prometheus service after making the required changes.

# Create a new job in Prometheus called cadvisor and add localhost:8070 as a target. Restart the Prometheus service after making the required changes

Edit /etc/prometheus/prometheus.yml file:


vi /etc/prometheus/prometheus.yml



Add below given lines under scrape_configs:


  - job_name: "cadvisor"
    static_configs:
      - targets: ["localhost:8070"]



Restart prometheus service:


systemctl restart prometheus