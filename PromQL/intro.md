Is query language within prometheus
Data returned can be visualized in graph.

# Section outline
Expression Data structure
Selector and modifiers
Operators and Functions
Vectors matching
Aggregations
Subqueries
Histogram/summary metrics

# PromQL Data types
A promql expression can evaluate of four types:
- string 
- Scaler - simple numeric floating point value
- Instant Vector: a set of time series containing a single sample for each time series, all sharing the c¨name timestamp (metric_name{labels} value)
- Range vector: range of data points (node_cpu_seconds_total[3m]) pass three minutes