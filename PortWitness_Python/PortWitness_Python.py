"""
Python implementation of portwitness //AN OSINT TOOL//
"""

import socket
import sys 
import os
import subprocess

def Sublist3r(domain):
	dom=str(domain) 
	out=subprocess.Popen(['./sublist3r.py' ,'-d',domain,'-o','test3.txt'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,shell=False)
	output,error=out.communicate()
	connection_Test()

def connection_Test():
	file2=open("test3.txt",'r')
	file_list=list(file2)
	a=[]
	for i in file_list:
		a.append(i.rstrip("\n"))
	for j in a:
		try:
			obj=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
			s=socket.gethostbyname(j)
		except Exception as ex:
			print "[x] Sub-domain %s Hostname cannot be Resolved //Inactive//\n" %(j)
			continue
		try:
			obj.connect((s,80))
			print ">> Connected to sub-domain \033[32m %s \033[0m on 80\n" %(j)
		except Exception as ex:
			print "[x] Sub-domain %s Inactive on port 80\n" %(j)

		try:
			obj.connect((s,443))
			print ">> Connected to sub-domain \033[32m %s \033[0m on 443\n" %(j)
		except Exception as ex:
			print "[x] Sub-domain %s Inactive on port 443\n" %(j)
			continue
			
	file2.close()
	obj.close()

def main():
	if (len(sys.argv)<2):
		print "Please Enter The Domain Name"
	else:
			domain=sys.argv[1]
			Sublist3r(domain)

main()

