#!/bin/bash
tput clear
if [ "$1" == "" ]; then
	tput bold
	echo -e  "\033[32m ###                PortWitness               ###"
	echo -e  "\033[32m ###              OSINT @tikoo_sahil          ###\n"
	echo -e  "\033[34m [!]Usage: ./portwitness.sh url"
else 
        tput bold
        echo -e  "\033[32m ###                PortWitness               ###"
        echo -e  "\033[32m ###                OSINT @tikoo_sahil        ###\n"
	echo -e  "\033[34m [!] Want to check for the sub-domain enum(Y,N)?"
        read enum
        if [ "$enum" == "Y" ] || [ "$enum" == "y" ]; then
	       cd Sublist3r
               echo "Searching For Sub-Domains ........"
               m=`./sublist3r.py -d $1 -o output.txt`
               if [ -f ip_$1.txt ]; then
                        rm ip_$1.txt 
               		while read -r line; do
                        	echo `nslookup $line | awk '/^Address: / { print $2 }'` >> ip_$1.txt
               		done < "output.txt"
               else
               		while read -r line; do
                        	echo `nslookup $line | awk '/^Address: / { print $2 }'` >> ip_$1.txt
               		done < "output.txt"
               fi
	       echo "[*] IP's for all sub-domains generated in ./Sublist3r/ip_$1.txt"
               if [ -f port_status_$1.txt ]; then
                        rm port_status_$1.txt
               		l=`nmap -p 80,443 -Pn -iL ip_$1.txt -oG port_status_$1.txt`
               else
                        l=`nmap -p 80,443 -Pn  -iL ip_$1.txt -oG port_status_$1.txt`
               fi 
               if [ -f active_ip_$1.txt ]; then
               		rm active_ip_$1.txt
               		echo `cat port_status_$1.txt | grep Up | cut -d ":" -f 2 | cut -d " " -f 2` > active_ip_$1.txt
               else 
                   	echo `cat port_status_$1.txt | grep Up | cut -d ":" -f 2 | cut -d " " -f 2` > active_ip_$1.txt
               fi
               echo "[*] All the active IP's are generated in ./Sublist3r/active_ip_$1.txt"
               while read -r line;do
               		b=`host $line | cut -d " " -f 5`
                        echo "[~] $b is active"
               done < "active_ip_$1.txt"
        else
               echo "[*] Checking Whether Domain working or not !!"
               echo `nslookup $1 | awk '/^Address: / { print $2 }'` > y.txt
               o=`nmap -p 80,443 -sX -Pn -iL y.txt -oG domain_status.txt`
               z=`cat domain_status.txt | grep Up | cut -d ":" -f 2 | cut -d " " -f 2` 
               if [ "$z" != "" ];then
              		 echo "[!] $1 is active "
               else
               		echo "[!] $1  is down"
               fi
   	 fi
fi
