#!/usr/bin/env bash

set -o errexit
set -o pipefail

function create_subscriptions() {
	
	printf "Enter a quantity of subscriptions to be created: \n"
	read sub_quantity
	for i in {1.."$sub_quantity"} 
		do 
			plesk bin subscription --create subscription$1.test -owner admin -service-plan "Default Domain" -login clone$1 -passwd "1qazXSW@1qazXSW@" 
		done
}

function main() {
	create_subscriptions
}

main "$@"