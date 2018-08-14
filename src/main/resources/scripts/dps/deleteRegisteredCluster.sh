#!/bin/bash
if [ $# -ne 3 ]; then
        echo "Please pass DataPlane Host to run as the first argument, cluster name as second arg and data center as as third arg"
else
        deleteRequestURL="https://$1/api/lakes?clusterName=$2&datacenterName=$3"

        echo "Delete Request URL is: " $deleteRequestURL
        echo "dp_jwt is: " $DP_JWT
	echo "hadoop-jwt is: " $HADOOP_JWT
        curl -k -b "dp_jwt=$DP_JWT; hadoop-jwt=$HADOOP_JWT;" -X DELETE "$deleteRequestURL"
fi
