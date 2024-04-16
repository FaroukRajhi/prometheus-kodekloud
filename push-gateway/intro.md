Batch jobs only run for a short period of time and then exit which makes it difficult for prometheus to scrape.
The push gateway acts as a middleman between the batch job and the prometheus server.
Batch push the metric to the push gateway.

Check documentation for installation and configuration details.