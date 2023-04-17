#!/bin/bash

########################################
#              README
# Name:   setup vm env script
# Author: haoyu.gao
# Data:   2023-4-16 
# Using:  ./setup_vm.sh $user-name $user-email
########################################

user_name=$1
user_email=$2
work_path=$HOME/codelab
log_file="/tmp/install.log"


function log_record() {
    local log= $1
    echo "${log}"
    echo "${log}" > $log_file
}


function install_vscode() {
    echo "start install vscode"
}

function install_gcc() {
    log_record "start install gcc"
    apt-get install gcc
    if [ $? -ne 0 ];then
        log_record "fail install gcc"
    else
        log_record "success install gcc"
    fi
}

function install_golang() {
    echo "start install golang"
    apt-get install golang
    if [ $? -ne 0 ];then
        log_record "fail install golang"
    else
        log_record "success install golang"
    fi
}

function install_python() {
    echo "start install python"
    apt-get install python
    if [ $? -ne 0 ];then
        log_record "fail install python"
    else
        log_record "success install python"
    fi
}

function install_tools() {
    log_record "##################################"
    log_record "# start install tools"
    log_record "##################################"

    apt-get update
    apt-get upgrade
    apt-get install curl make cmake vim net-tools openssh-server libssl-dev binutils g++ gawk gcc git git-core automake  
    if [ $? -ne 0 ];then
        log_record "fail install python"
    else
        log_record "success install python"
    fi
}

function install_postman() {
    echo "start install postman"
}

function set_env() {
    log_record "start set env params"
    log_record "set git config"
    git config --global user.name "$user_name"
    git config --global user.email "$user_email" 
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.io,direct
}

mkdir -p $work_path
[ -f $log_file ] || touch $log_file
chmod 666 $log_file

log_record "start install essentional component"
install_tools
#install_vscode
#install_gcc
install_golang
set_env
#install_postman
log_record "finish install"