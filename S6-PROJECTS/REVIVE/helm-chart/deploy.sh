#! /bin/bash
helm install  catalog-db catalog-db
helm install  checkout-db checkout-db
helm install  carts-db carts-db
helm install  orders-db orders-db
helm install  rabbitmq rabbitmq
helm install  catalog catalog
helm install  checkout checkout
helm install  carts carts
helm install  orders orders
helm install  ui ui
helm install  assets assets
