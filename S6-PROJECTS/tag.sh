#!/bin/bash
############# Check if TAG_NUMBER is not empty  ##############
 if [ -z "$1" ]
  then
     echo "Error: TAG_NUMBER is empty"
     exit 1
 fi
########### Check if BRANCH is not empty  ##################
 if [ -z "$2" ]
  then
     echo "Error: BRANCH is empty"
     exit 1
 fi
 
  ##### Check if COMMIT_MESSAGE is not empty ##########
 if [ -z "$3" ]
  then
     echo "Error: COMMIT_MESSAGE is empty"
     exit 1
 fi
 ############### Check if DEPLOYER_NAME is not empty  ###########
 if [ -z "$4" ]
  then
     echo "Error: DEPLOYER_NAME is empty"
     exit 1
 fi
## Check if TAG_NUMBER contains only numbers
######### SETTING ARGUMENTS   #####################################
FIRST=`echo $1  | awk -F. '{print $1}'`
SECOND=`echo $1 | awk -F. '{print $2}'`
THIRD=`echo $1  | awk -F. '{print $3}'`
############ Check if the provided values are numbers only   ###########
is_number() {
    case $1 in
        ''|*[!0-9]*) return 1 ;; # not a number
        *) return 0 ;; # a number
    esac
}
if is_number "$FIRST" && is_number "$SECOND" && is_number "$THIRD"; then
    echo "The values are numbers."
else
    echo "At least one value is not a number."
    exit 1
fi

























