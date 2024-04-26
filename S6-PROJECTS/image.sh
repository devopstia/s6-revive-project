#!/bin/bash
########### Check if TAG is not empty  ##################
 if [ -z "$1" ]
  then
     echo "Error: TAG  is empty"
     exit 1
 fi
 ############# Check if UI is not empty  ##############
 if [ -z "$2" ]
  then
     echo "Error: UI is empty"
     exit 1
 fi
  ##### Check if CATALOG is not empty ##########
 if [ -z "$3" ]
  then
     echo "Error: CATALOG is empty"
     exit 1
 fi
 ############### Check if CATALOG-DB is not empty  ###########
 if [ -z "$4" ]
  then
     echo "Error: CATALOG-DB  is empty"
     exit 1
 fi
 ############### Check if CART is not empty  ###########
 if [ -z "$5" ]
  then
     echo "Error: CART  is empty"
     exit 1
 fi
 ############### Check if CART-DB is not empty  ###########
 if [ -z "$6" ]
  then
     echo "Error: CART-DB  is empty"
     exit 1
 fi
 ############### Check if ORDERS is not empty  ###########
 if [ -z "$7" ]
  then
     echo "Error: ORDERS  is empty"
     exit 1
 fi
 ############### Check if ORDERS-DB is not empty  ###########
 if [ -z "$8" ]
  then
     echo "Error: ORDERS-DB  is empty"
     exit 1
 fi
 ############### Check if CHECKOUT is not empty  ###########
 if [ -z "$9" ]
  then
     echo "Error: CHECKOUT  is empty"
     exit 1
 fi
 ############### Check if CHECKOUT-DB is not empty  ###########
 if [ -z "$10" ]
  then
     echo "Error: CHECKOUT-DB  is empty"
     exit 1
 fi
 ############### Check if ASSETS is not empty  ###########
 if [ -z "$11" ]
  then
     echo "Error: ASSETS  is empty"
     exit 1
 fi
 ############### Check if ASSETS-DB is not empty  ###########
 if [ -z "$12" ]
  then
     echo "Error: ASSETS-DB  is empty"
     exit 1
 fi

UI=`echo $1  | cut -c1`
CATALOG=`echo $2  | cut -c1`
CATALOG-DB=`echo $3  | cut -c1`
CARTS=`echo $4  | cut -c1`
CARTS-DB=`echo $5  | cut -c1`
ORDERS=`echo $6  | cut -c1`
ORDERS-DB=`echo $7  | cut -c1`
CHECKOUT=`echo $8  | cut -c1`
CHECKOUT-DB=`echo $9  | cut -c1`
ASSETS=`echo $10  | cut -c1`
ASSETS-DB=`echo $11  | cut -c1`
# Check if all  TAG  starts with 'v'
if [ $UI == v ] && [ $CATALOG == v ] && [ ${CATALOG-DB} == v ] && [ $CARTS == v ] && [ ${CARTS-DB} == v ] && [ $ORDERS == v ] && [ ${ORDERS-DB} == v ] && [ $CHECKOUT == v ] && [ ${CHECKOUT-DB} == v ] && [ $ASSETS == v ] && [ ${ASSETS-DB} == v ]
 then
    echo "all TAG starts with 'v'"
else
    echo "all or some of the TAG  does not start with 'v'"
    exit 1
fi














