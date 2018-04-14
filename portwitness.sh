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
        if [ "$enum" == "Y" ] || [ "$enum" == "y" ]; then
	       cd Sublist3r
               echo "Searching For Sub-Domains ........"
               m=`./sublist3r.py -d $1 -o output.txt`
               while read -r line; do
                        echo `nslookup $line | awk '/^Address: / { print $2 }'` >> ip.txt
               done < "output.txt"
               echo "[*] IP's for all sub-domains generated in ./Sublist3r/ip.txt"
               l=`nmap -p 80,443 -Pn -iL ip.txt -oG port_status.txt`
               echo `cat port_status.txt | grep Up | cut -d ":" -f 2 | cut -d " " -f 2` > active_ip.txt
               echo `awk ' { for(i=1;i<=NF;i++) { print $i } } ' active_ip.txt` > active_ip[1].txt
               echo "[*] All the active IP's are generated in ./Sublist3r/active_ip[1].txt"
               while read -r line;do
               		b=`host $line | cut -d " " -f 5`
                        echo "[~] $b is active"
               done < "active_ip[1].txt"
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
