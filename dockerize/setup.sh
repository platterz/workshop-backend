#!/usr/bin/env bash

aws configure set aws_access_key_id AKIAW3H6IOWLLTMIISUO
aws configure set aws_secret_access_key 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
aws configure set default.region us-east-1

mkdir -p ~/.kube
cp ~/.kube/config ~/.kube/config.bak
KUBECONFIG=./playground-cluster-kubeconfig.yaml:~/.kube/config.bak kubectl config view --flatten > ~/.kube/config

