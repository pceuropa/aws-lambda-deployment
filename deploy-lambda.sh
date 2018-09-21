#!/usr/bin/env bash

R='\e[31m'
G='\e[32m'
Y='\e[33m'
C='\e[96m'
NC='\033[0m' # No Color
PYTHON_VER='3.7'
LAMBDA_RUNTIME='python3.6'
LAMBDA_ROLE='arn:aws:iam::0008907699:role/role_name'

function create_function {

  printf "${Y}Zip requirements packages from virtual venv? [y/N]${NC} "
  read response
  response=${response}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
      cd $VIRTUAL_ENV/lib/python$PYTHON_VER/site-packages/
      zip -r --quiet ../../../../project.zip *
      cd ../../../../
  fi

  printf "${Y}Add files to project.zip? [y/N]${NC} "
  read response
  response=${response}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
      zip -g project.zip *
  fi

  printf "${Y}deploy.zip? [y/N]${NC} "
  read response
  response=${response}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
    read -r -p "FunctionName:  " function_name
    read -r -p "Handler:  " handler

    aws lambda create-function --function-name ${function_name} --runtime $LAMBDA_RUNTIME --handler ${handler}  --role ${LAMBDA_ROLE} \
    --zip-file fileb://project.zip --description "Description"  >> lambda_config.json 2>&1
    cat lambda_config.json
  fi
}

function read_function {
    read -r -p "Function name:  " function_name
    aws lambda get-function --function-name ${function_name}
}
function update_function {

  printf "${Y}Zip requirements packages? [y/N]${NC} "
  read response
  response=${response}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
      cd venv/lib/python3.7/site-packages/
      zip -r --quiet ../../../../project.zip *
      cd ../../../../
  fi

  printf "${Y}Update lamba function? [y/N]${NC} "
  read response
  response=${response}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
    zip -g project.zip *.py
    sed -n 2p lambda_config.json
    read -r -p "Function name:  " function_name
    aws lambda update-function-code --function-name ${function_name}  --zip-file fileb://project.zip
  fi
}


function delete_function {
    echo Config this project
    cat lambda_config.json
  printf "${R}Function name: ${NC} "
    read -r function_name
    aws lambda delete-function --function-name ${function_name}
}


printf "Action: ${Y}[C]reate/[U]pdate/[R]ead/[D]elete? [c/r/u/d]${NC} "
  read response
  response=${response}    # tolower

  if [[ "$response" =~ ^(c|C)$ ]]
  then
    echo Start process creating lambda function...
    create_function
  fi

  if [[ "$response" =~ ^(u|U)$ ]]
  then
    echo Start process update lambda function...
    update_function
  fi

  if [[ "$response" =~ ^(r|R)$ ]]
  then
    read_function
  fi

  if [[ "$response" =~ ^(d|D)$ ]]
  then
    delete_function
  fi
