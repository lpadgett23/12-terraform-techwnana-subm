#!/bin/bash

# Apply the aws-auth ConfigMap
kubectl apply -f aws-auth-cm.yaml

# Apply the  ClusterRoleBinding
kubectl apply -f clusterrolebinding.yaml