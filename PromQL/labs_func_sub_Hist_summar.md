# There are three jobs we added in Prometheus, multimedia, auth, and api. Construct a query that will fetch the node_cpu_seconds_total metric for all jobs and sort it in an ascending order. Save the query in /root/ascending.txt file
sort(node_cpu_seconds_total)

# Construct a query that will return the metric node_memory_Active_bytes for all jobs and sort the results in a descending order. Save the query in /root/descending.txt file.

sort_desc(node_memory_Active_bytes)

# Calculate the percentage of free space for all filesystems on all instances under all jobs using below query:

round(node_filesystem_avail_bytes*100/node_filesystem_size_bytes)

# Construct a query that will show the rate of context switches using a 2m time window.

rate(node_context_switches_total{instance="node01:9100"}[2m])

# Calculate the rate of received node_network_receive_bytes_total using 2-minute window, sum the rates across all interfaces, and group the results by instance. 
sum by(instance) (rate(node_network_receive_bytes_total[2m]))

# Construct a subquery that will calculate the rate at which all cpus spent in iowait mode using a 1 minute time window for the rate function. Find the max value of this result over the past 10 minutes using a 30s query step for the subquery.
To get the max value of a range vector, the max_over_time function needs to be used. Since we need to find the max rate at which cpus spend in iowait mode, the rate function returns an instant vector and the max_over_time expects a range vector. In this case a subquery needs to be used. In [] there’s two subquery values that need to be passed. The first one is how far back should we go to get the rate, the question had asked for 10 minutes. The second value is the query step. The query step tells prometheus how frequently to calculate the rate. So 30s query step means a rate value will be calculated every 30s and passed into the max_over_time function.

max_over_time(rate(node_cpu_seconds_total{mode="iowait"}[1m]) [10m:30s])

# For the http_request_total metric, what is the query/metric name that would be used to get the count of total requests on node node01:3000

Histogram metrics come with a _count metric to give you the total number of observations. The required query would be http_request_total_count{instance="node01:3000"}

# Construct a query to return the total number of requests for the /events route with a latency of less than 0.4s across all nodes.
To find the number of requests that took less than 0.4s, grab the http_request_total_bucket metric and set the label to le="0.4" to find all requests that fell into that bucket. Since the question had specifically asked for requests for the /events route, pass in a label route="/events". 

http_request_total_bucket{route="/events", le="0.4"}

# Construct a query to find out how many requests took somewhere between 0.08s and 0.1s on node node02:30

To get the number of observations between two buckets you will need to subtract the difference between the two. Since the le label will be different between the two vectors, we will need to ignore the le label. Final query would be

http_request_total_bucket{instance="node02:3000", le="0.1"} - ignoring(le) http_request_total_bucket{instance="node02:3000", le="0.08"}

# Construct a query to calculate the rate of http requests that took less than 0.08s. Use a time window of 1m across all nodes.
Apply the rate function to the http_request_total_bucket and use a selector to select le="0.08" to get requests that took less than 0.08s. Final query would be:

rate(http_request_total_bucket{le="0.08"}[1m])

# Construct a query to calculate the average latency of a request over the past 4 minutes. Use the formula below to calculate average latency of request.

rate of sum-of-all-requests / rate of count-of-all-requests

rate(http_request_total_sum[4m])/ rate(http_request_total_count[4m])

# Management would like to know what is the 95th percentile for the latency of requests going to node node01:3000. Construct a query to calculate the 95th percentile. 
histogram_quantile(0.95, http_request_total_bucket{instance="node01:3000"})

# Construct a query to get what is the 90th percentile for uploaded bytes on node node01:3000
To get the 90th percentile of the http_upload_bytes metrics for instance node01:3000, add a selector that matches on the quantile="0.9" label. 

http_upload_bytes{instance="node01:3000", quantile="0.9"}



