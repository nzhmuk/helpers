#!/usr/bin/env bash

set -o errexit
set -o pipefail

IPV4_REGEX="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"
SUBSCRIPTION_IP=0

function set_weak_password() {

	printf "Set weak password strength"
	plesk bin server_pref -u -min_password_strength very_weak
}

function get_subscription_ip() {

        ip_addresses=( $(hostname -I) )
        ip_addresses_quantity=${#ip_addresses[@]}
        index=0

        printf "List of available IPv4 addresses on the server [IP address - index]:\n"
        while [ "$index" -lt "$ip_addresses_quantity" ]
        do
			if [[ ${ip_addresses[$index]} =~ $IPV4_REGEX ]]; then
				echo "${ip_addresses[$index]} - $index "
			fi
            let "index = $index + 1"
        done

        printf "Enter index for the selected IP address: \n"
        read selected_id
        SUBSCRIPTION_IP="${ip_addresses[$selected_id]}"
}

function create_subscriptions() {

        printf "Enter a quantity of subscriptions to be created: \n"
        read sub_quantity
        printf "Enter prefix for subscriptions name (latin, no spaces and special characters): \n"
        read sub_prefix
        printf "Enter a prefix for sysuser (latin, no spaces and special characters): \n"
        read sub_sysuser
	
	hostname=( $(hostname | cut -d . -f 1) )

        for i in $(seq 1 "$sub_quantity")
        do
            plesk bin subscription --create $sub_prefix$i.$hostname.qa.plesk.tech -owner admin -service-plan "Default Domain" -ip $SUBSCRIPTION_IP -login $sub_sysuser$i -passwd "setup1Q***"
        done
}

function main() {
	set_weak_password()
        get_subscription_ip
        create_subscriptions
}

main "$@"
