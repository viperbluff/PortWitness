#!/bin/bash
tput clear
if [ "$1" == "" ]; then
	tput bold
	echo -e  "\033[32m ###                PortWitness               ###"
	echo -e  "\033[32m ###              OSINT @tikoo_sahil          ###\n"
	echo -e  "\033[34m [!]Usage: ./portwitness.sh url\e[0m"
else 
        tput bold
        echo -e  "\033[32m ###                PortWitness               ###"
        echo -e  "\033[32m ###                OSINT @tikoo_sahil        ###\n"
	echo -e  "\033[34m[!]Check for Active Sub-Domains(Y,N)?\e[0m"
        read enum
        if [ "$enum" == "Y" ] || [ "$enum" == "y" ]; then
	       cd Sublist3r
               echo -e "\n"
               echo -e "\e[1m\033[31m[!]\e[0mSearching For Sub-Domains ........\e[0m\n"
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
	       echo -e "\e[1m\e[34m[!]\e[0m IP's for all sub-domains generated in ./Sublist3r/ip_$1.txt\e[0m"
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
               if [ -f result.txt ]; then
               		rm result.txt
                        a=`awk ' { for(i=1;i<=NF;i++) { print $i } } ' active_ip_$1.txt| tee -a result.txt`
	       else
               		a=`awk ' { for(i=1;i<=NF;i++) { print $i } } ' active_ip_$1.txt| tee -a result.txt`
               fi
               echo -e "\e[1m\e[34m[!]\e[0m All the active IP's are generated in ./Sublist3r/result.txt\e[0m\n" 
               echo -e "\e[1m\e[34m[!]\e[0mThe Following sub-domains are Scanned:\e[0m"
               if [ -f active_domain.txt ]; then
               		rm active_domain.txt 
               		while read -r line;do
                        	r=`nslookup $line | awk '/^Address: / { print $2 }'`
                        	if [ "$r" == "" ];then
                        		echo -e "\e[1m\e[31m[!]\e[0m\e[0m$line is \e[31minactive\e[0m"
                        	else
                        		file_exist=$(cat result.txt | grep -c "$r")
                        		if [ $file_exist -eq 0 ]; then  
                        			echo -e "\e[1m\e[31m[~]\e[0m\e[0m $line is \e[31minactive\e[0m"
                        		else 
                                        	echo -e "\e[1m\e[34m[!]\e[0m\e[0m$line is \e[32mactive\e[0m" 
                                        	echo -e "\e[1m\e[34m[!]\e[0m\e[0m$line is \e[32mactive\e[0m" >> active_domain.txt
                                        fi
                                fi
                        done < "output.txt"
                else
                	while read -r line;do
                        r=`nslookup $line | awk '/^Address: / { print $2 }'`
                        if [ "$r" == "" ];then
                                echo -e "\e[1m\e[31m[!]\e[0m\e[0m$line is \e[31minactive\e[0m"
                        else
                                file_exist=$(cat result.txt | grep -c "$r")
                                if [ $file_exist -eq 0 ]; then  
                                        echo -e "\e[1m\e[31m[~]\e[0m\e[0m $line is \e[31minactive\e[0m"
                                else 
                                        echo -e "\e[1m\e[34m[!]\e[0m\e[0m$line is \e[32mactive\e[0m" 
                                        echo -e "\e[1m\e[34m[!]\e[0m\e[0m$line is \e[32mactive\e[0m" >> active_domain.txt
  
                                fi 
                        fi
                        done < "output.txt"
                fi
               echo -e "\e[1m\e[35m[!]\e[0mList of all the active sub-domains is stored under ./Sublist3r/active_domain.txt\e[0m" 
        else
               echo -e "\e[1m\e[32m[*]\e[0m Checking Whether Domain working or not !!"
               echo `nslookup $1 | awk '/^Address: / { print $2 }'` > y.txt
               o=`nmap -p 80,443 -A -sX -Pn -iL y.txt -oG domain_status.txt`
               z=`cat domain_status.txt | grep Up | cut -d ":" -f 2 | cut -d " " -f 2` 
               if [ "$z" != "" ];then
              		 echo "\e[34m[!]\e[0m $1 is active "
               else
               		echo "\e[31m[!]\e[0m $1  is down"
               fi
   	 fi
fi
