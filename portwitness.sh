#!/bin/bash
tput clear
if [ "$1" == "" ]; then
tput bold
echo -e  "\033[32m ###                PortWitness      ###"
echo -e  "\033[34m ###                OSINT @tikoo_sahil ###\n"
echo     "[*]Specify a Domain name"
else 
        tput bold
        echo -e  "\033[32m ###                PortWitness      ###"
        echo -e  "\033[34m ###                OSINT @tikoo_sahil ###\n"
	echo "[*] Want to check for the sub-domain enum(Y,N)?"
        read enum
        if [ "$enum" == "Y" ]; then
	       cd Sublist3r
               echo "Searching For Sub-Domains ........"
               `./sublist3r.py -d $1 -o output.txt`
               echo output.txt > x
               while read -r line; do
                        echo `nslookup $line | awk '/ Address: / { print $2 }'` > ip.txt
               done < "$x"
               echo "[*] IP's for all sub-domains generated in ./ip.txt"
               nmap -p 80,443 -iL ip.txt -oG port_status.txt
               cat port_status.txt | grep Up | cut -d ":" -f 2| cut -d " " -f 2 > Working_ips.txt
               echo "[*] All the Working IP's stored in ./Working_ips.txt"
               echo Working_ips.txt > a
               while read -r line;do 
               		`host $line | cut -d " " -f 5` > b
                        echo "[~] $b is active"
               done < "$a"
        else
               echo "[*] Checking Whether Domain working or not !!"
               echo `nslookup $1 | awk '/ Address: / { print $2 }'` > y
               nmap -p 80,443 -sX $y -oG domain_status.txt
               cat domain_status.txt | grep Up | cut -d ":" -f 2| cut -d " " -f 2 > Working_domain.txt
               echo Working_domain.txt > z
               if [ "$z" != "" ];then
              		 echo "[!] $1 is active "
               else
               		echo "[!] $1  is down"
               fi
   	 fi
fi
