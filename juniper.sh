#!/bin/bash
host2connect=dummy
port2connect=0
if [[ $@ =~ "--help" || $# -eq 0 ]]; then
echo -e "run with \njuniper.sh start or \n\
juniper.sh start -u/--username foo or \n\
juniper.sh stop\n\
you can also provide a hostname (with -h/--host) and/or a port (with -p/--port) to connect to. But You probably want to edit the script and set it here"
exit 0
fi
start_stop=$(echo "$1" | tr "A-Z" "a-z")
if [[ $start_stop = "start" || $start_stop = "stop" ]];then
shift
else
echo "start or stop musst be the first parameter"
exit 1
fi
while [[ $# > 1 ]]
do
key="$1"
shift

case $key in
    -u|--username)
    VPN_USER="$1"
    shift
    ;;
    -h|--host)
    host2connect="$1"
    shift
    ;;
    -p|--port)
    port2connect="$1"
    shift
    ;;
    *)
    ;;
esac
done

cd /usr/local/nc

if [[ $start_stop = "stop" ]]; then
        ./ncsvc -K
else
	if [[ $port2connect -eq 0 || $host2connect == "dummy" ]]; then
		echo "$host2connect:$port2connect will not work - promised. Start with -h/--host and -p/--port or change script"
		exit 1
	fi
        VPN_USER=${VPN_USER:-$USER}

        openssl s_client -connect $host2connect":"$port2connect <<<"" 2>&1 | sed -ne '/BEGIN CERTIFICATE/,/END CERTIFICATE/p' | openssl x509 -out ~/cert.der -outform der

        stty -echo
        read -p "Password: " passwd; echo
        stty echo

        ./ncsvc -L 5 -l 5 -h $host2connect -u $VPN_USER -p $passwd -r REALM_AD_LDAP -f ~/cert.der > /dev/null 2>&1 &
        sleep 5;
        if [[ $(ifconfig tun0 > /dev/null 2>&1 ; echo $?) -eq 0 ]]; then
		echo "connected to $host2connect"
        else
		echo "something went wrong connecting to $host2connect. Check ~/.juniper_networks/network_connect/ncsvc.log"
                ./ncsvc -K
	fi
fi

