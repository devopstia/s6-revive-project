#!/bin/bash

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=assets

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=carts

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=catalog

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=checkout

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=orders

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=rabbitmq

 kubectl create secret docker-registry ecr-revive \
   --docker-server=637423375996.dkr.ecr.us-east-1.amazonaws.com \
   --docker-username=AWS \
   --docker-password="$(aws ecr get-login-password --region us-east-1)" \
   --namespace=ui

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 637423375996.dkr.ecr.us-east-1.amazonaws.com
