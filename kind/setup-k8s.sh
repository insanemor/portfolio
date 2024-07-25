#!/bin/bash

# Obtenha o nome do contêiner do servidor API do Kubernetes
API_SERVER_CONTAINER=$(docker ps --filter "name=portfolio-control-plane" --format "{{.ID}}")

# Obtenha o IP do contêiner do servidor API
API_SERVER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $API_SERVER_CONTAINER)

# Atualize o kubeconfig com o novo IP e porta 6443
KUBECONFIG_PATH=$HOME/.kube/config
sed -i "s|https://127.0.0.1:[0-9]*|https://$API_SERVER_IP:6443|g" $KUBECONFIG_PATH

echo "Kubernetes cluster configured with API server at https://$API_SERVER_IP:6443"
