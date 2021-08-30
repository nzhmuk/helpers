#!/usr/bin/env bash

set -o errexit
set -o pipefail

function collect_ips() {
                ip_addresses=( $(hostname -I) )
#                declare -p ip_addresses

                ip_addresses_quantity=${#ip_addresses[@]}

                printf "Number of IP addresses:\n"
                echo $ip_addresses_quantity

                for each_ip in { 0..$ip_addresses_quantity }
                do
                        echo $each_ip
                done
}

function create_subscriptions() {

        printf "Enter a quantity of subscriptions to be created: \n"
        read sub_quantity
        for i in {1.."$sub_quantity"}
                do
                        plesk bin subscription --create subscription$1.test -owner admin -service-plan "Default Domain" -ip $ip -login clone$1 -passwd "1qazXSW@1qazXSW@"
                done
}

function main() {
        collect_ips
#       create_subscriptions


}

main "$@"