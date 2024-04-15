When you perform a query and provide a metric name(node_filesystem_avail_bytes),
it's going to return all time series with that metric.
We can filter using the:

# Label matchers:
 allow as to match on specific labels
  = exact value node_filesystem_avail_bytes{"instance=node1"}
  != Not equal node_filesystem_avail_bytes{"instance=!node1"}
  =~ regular expression matcher - matches time series with labels that match regex
  node_filesystem_avail_bytes{"device=~"/dev/sda.*"}
  !~ Negative regular expression matcher node_filesystem_avail_bytes{"device!~"/dev/sda."}

We can add more matchers in the same query
node_filesystem_avail_bytes{"device=~"/dev/sda.", "other_device!~"/dev/sda}