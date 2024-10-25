#!/bin/bash

NAMESPACE="bank-namespace"
replicasets=($(kubectl get rs -n $NAMESPACE -o jsonpath='{.items[*].metadata.name}'))

echo "다음 ReplicaSet 중 하나를 선택하세요!"
for i in "${!replicasets[@]}"; do
    echo "$((i + 1)). ${replicasets[i]}"
done

read -p "종료할 ReplicaSet 번호를 입력하세요 >> " choice
if [[ $choice -ge 1 && $choice -le ${#replicasets[@]} ]]; then
    rs_to_delete="${replicasets[$((choice - 1))]}"
    kubectl delete rs "$rs_to_delete" -n $NAMESPACE --grace-period=0 --force
    echo "$rs_to_delete ReplicaSet이 강제로 종료되었습니다."
else
    echo "잘못된 선택입니다."
fi
