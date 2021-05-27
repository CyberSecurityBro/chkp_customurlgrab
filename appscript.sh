#!/bin/bash
mgmt_cli login -u apiusername -p 'P@ssW0rd' > id.txt
TOTAL=`mgmt_cli -s id.txt show application-sites details-level full  -f json | jq -r '.total'`
i=0
while [[ $i -lt ${TOTAL} ]];
do
  mgmt_cli -s id.txt show application-sites details-level full -f json limit 200 offset ${i} | jq  -r '.objects[]|select(."user-defined" == true)'
  let "i = $i + 200"
done
