Let's say that we have a gauge metric and we want to find what was the maximum value for this metric over the past 10 minutes.
max_ove_time(node_filesystem_avail_bytes[10m])

find the rate
max_ove_time(rate(http_requests_total[10m])

subquery format
<instant_query>[<range>:<resolution>] [offset <duration>]
rate(http_requests_total[1m]) [5m:30s]