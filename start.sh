#!/bin/bash

#Function to print info logs
function logInfo() {
   echo `date "+%m/%d/%Y %H:%M:%S"` " $@"
}

#Function to print failure logs and exit installation
function logFailure() {
   echo `date "+%m/%d/%Y %H:%M:%S"`
   echo ""
   echo " ERROR: $@"
   echo ""
   echo `date "+%m/%d/%Y %H:%M:%S"`
   sleep 10
   exit 1
}

function installprotoc() {
     logInfo "Installing  rpms..."
    command -v protoch > /dev/null 2>&1;rc=$?
	if [ $rc -ne 0 ]; then
		logFailure "Could not determine proto,rc=$rc"
        wget https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip
	fi
}

function main() {
    installprotoc
	exit 0
}

umask 0077
main "$@"