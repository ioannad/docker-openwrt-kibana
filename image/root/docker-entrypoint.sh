#!/bin/bash

set -x

# Add kibana as command if needed
if   [[ -z "$1" || ( "$1" = 'kibana' && -z "$2" ) ]] 
then /opt/kibana/bin/kibana -c /data/config/kibana.yml
else exec $*
fi
