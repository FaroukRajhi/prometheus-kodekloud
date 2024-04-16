Aggregation operators, allow you to take an instant vector and aggregate its elements, resulting in a new instant vector with fewer elements.
sum
Min
Max
Avg
Group: all values in the resulting vector are 1
stddev: calculate population standard variance over dimensions
count : count number of elements in the vector
count values: smallest elements by sample value
bottomk: smallest element by sample value
Topk: largest element by sample value
quantile:  

example:
http_requests
sum(http_requests)
max(http_requests)
min(http_requests)
avg(http_requests)

# By clause
The clause allows you to choose which labels to aggregate along
sum by(path) (http_requests)
sum by(instance) (http_requests) 

sum without(path) (http_requests)