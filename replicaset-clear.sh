#!/bin/bash
for rs in $(kubectl get replicasets -n bank-namespace --no-headers | awk '$4 == 0 {print $1}'); do
  kubectl delete replicaset $rs -n bank-namespace
done
