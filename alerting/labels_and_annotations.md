Labels can be added to alerts to provide a mechanism to classify and match specify alerts in alertManager.

groups:
  -name: node
   rules:
     - alert: Node down
       expr:up{job="node"} == 0
       labels:
         severity: warning

     - alert: Multiple Node down
       expr: avg without(instance)(up{job="node"} <=0.5)
       labels:
         severity: critical

# Annotation
Can be used to to provide additional information, however unlike labels they do no play a part in the alert identify.
So they cannot be used for routing in alertManager

groups:
  - name: node
    rules:
      - alert: node_filesystem_free_percent
        expr: 100 * node_filesystem_free_bytes{job="node"} / node_filesystem_size_bytes{job="node"} < 70
        annotations:
          description: "filesystem {{.labels.device}} on {{.labels.instance}} is low on space, current space is {{.values}}"