How metrics work in prometheus
The metric in prometheus has three different properties



<metric_name>[{<label_1="value_1">,<label_N="value_N">}] <metric_value>

First metric name: is going to be descriptive name of a metric
second labels: key-value pairs
Third : metric value that specific point in time

example:

node_cpu_second_total{cpu="0", mode="idle"} 258277.86
This metric represents the total number of seconds that the CPU spent in a specific mode
The label provide us information on which cpu this metric is for and for what cpu state idle
=> If we have more than one CPU the number increments
node_cpu_second_total{cpu="1", mode="idle"} 2581127.86
node_cpu_second_total{cpu="2", mode="idle"} 2522377.86
node_cpu_second_total{cpu="3", mode="idle"} 255477.86

# Timestamp
When prometheus scrapes a target and retrieves metrics, it also stores the time at which the metric was scraped as well
It look like this
1668215300 -> This called unix timestamp which is the number of seconds elapsed

# Time series

Is a stream of timestamped values sharing the same metric and set of labels

# Metric Attributes
Every metric have TYPE and HELP attributes for more information
#TYPE
#HELP

# Metric Types

- Counter Metric
Tells you how mane times did something happen.
- Gauge Metric
It measures what the current value of something
Can go up or down
- Histogram
Tell how long or how big something is
example: Track response time
Tell us how many total requests completed in less than 0.2 seconds
< 1s
< 0.5s
< 0.2s
Request size etc.

# Summary
Similar to histogram (track how long or how big)
How many observations fell below X

Response time
20% = .3s
50% = 0.8s
80% = 1s

# Metric Rules

Metric name specifies a general feature of a system to ve measured
May contain ASCII letters, underscores, and colons
Must match the regex [a-zA-Z_:][a-zA-Z0-0_:]*
Colons are reserved only for recording rules

# Labels
Allows you to split up a metric by a specific criterial
cpu=0 cpu= 1

