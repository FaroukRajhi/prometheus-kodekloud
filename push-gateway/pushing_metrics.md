Metrics can be pushed to the push gateway using one of the following methods:
Send HTTP request requests to the push gateway.
Prometheus client libraries.

# HTTP
Send HTTP POST request 
http://pushgateway_address:port/metrics/job/<job_name>/<label_1>/<value_1>/<label2>/<value2>

# Client libraries
Three function
push()-> PUT
pushadd()-> POST
delete()-> DELETE