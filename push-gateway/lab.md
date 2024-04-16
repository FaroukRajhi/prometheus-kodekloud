# Verify that the push gateway is running
curl localhost:9091/metrics

# Configure Prometheus to scrape the PushGateway. The job label should be pushgateway, and make sure that honor_labels is set to true so that the clients can set the job/instance labels.

vi /etc/prometheus/prometheus.yml



Add below lines under scrape_configs:


  - job_name: pushgateway
    honor_labels: true
    static_configs:
      - targets: ["localhost:9091"]



Restart the prometheus service:


systemctl restart prometheus

# Using the command below, push the processing_time_seconds 120 metric into a job labeled as {job="video_processing"}.

echo "processing_time_seconds 120" | curl --data-binary @- http://localhost:9091/metrics/job/video_processing


