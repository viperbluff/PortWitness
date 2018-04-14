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
               echo "[*] IP's for all sub-domains generated in ./ip.txt"
               echo ` nmap -p 80,443 -Pn -iL ip.txt` > port_status.txt
               echo `cat port_status.txt | awk '{ print $16 } '| tr -d '()'` > active_ip.txt
               echo "[*] All the active IP's are generated in ./active_ip.txt"
               while read -r line;do
               		`host $line | cut -d " " -f 5` > b
                        echo "[~] $b is active"
               done < "active_ip.txt"
        else
               echo "[*] Checking Whether Domain working or not !!"
               echo `nslookup $1 | awk '/^Address: / { print $2 }'` > y.txt
               echo ` nmap -p 80,443 -sX -Pn -iL y.txt` > domain_status.txt
               z=`cat domain_status.txt | awk '{ print $16 } '| tr -d '()'` 
               if [ "$z" != "" ];then
              		 echo "[!] $1 is active "
               else
               		echo "[!] $1  is down"
               fi
   	 fi
fi
