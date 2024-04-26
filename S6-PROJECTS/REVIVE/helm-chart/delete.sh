#! /bin/bash

helm delete $(helm list | grep -e  ui  -e assets   -e orders -e carts  -e checkout  -e catalog  -e rabbitmq  -e orders-db  -e carts-db  -e checkout-db  -e catalog-db | awk '{print $1}' 
)

kubectl delete pvc --all