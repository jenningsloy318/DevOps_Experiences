
#!/bin/bash

## tree nodes, 3 year retention, 64 shards
curl -X  POST  http://localhost:7201/api/v1/services/m3db/placement/set -d '{
  "type": "cluster",
  "namespaceName": "ems",
  "retentionTime": "25632h",
  "numShards": "64",
  "replicationFactor": "3",
  "hosts": [
        {
            "id": "prometheus-m3db-01",
            "isolationGroup": "m3db-01",
            "zone": "embedded",
            "weight": 100,
            "address": "10.180.1.27",
            "port": 9000
        },
        {
            "id": "prometheus-m3db-02",
            "isolationGroup": "m3db-02",
            "zone": "embedded",
            "weight": 100,
            "address": "10.180.1.11",
            "port": 9000
        },
        {
            "id": "prometheus-m3db-03",
            "isolationGroup": "m3db-03",
            "zone": "embedded",
            "weight": 100,
            "address": "10.180.1.12",
            "port": 9000
        }
    ]
}'

#curl -X DELETE  http://localhost:7201/api/v1/namespace/ems
#
#curl -X POST http://localhost:7201/api/v1/database/namespace/create -d '{
#  "namespaceName": "ems",
#  "retentionTime": "25632h"
#}'


