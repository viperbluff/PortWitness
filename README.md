# PortWitness v1.1 [Written in Python2]

This version of PortWitness has been developed in python2 in which modules like os,subprocess and sys etc have been used.The entire code is based on the concept of socket programming.Using Sockets we establish a connection with a web application to find out if its alive or not.This new version of PortWitness is more fast and accurate.

## Screenshots 

![PortWitness](https://raw.github.com/viperbluff/PortWitness/master/screenshots/portwitnessnew.png)

## Usage 

> **python2 _name_.py url**

# PortWitness v1.0 [Written in Bash]

PortWitness was designed as a bash tool to find out active domain and subdomains of websites using port scanning. It helps penetration testers and bug hunters collect and gather information about active subdomains for the domain they are targeting.PortWitness enumerates subdomains using Sublist3r and uses Nmap alongwith nslookup to check for active sites.Active domain or sub-domains are finally stored in an output file.Using that Output file a user can directly start testing those sites.

Sublist3r has also been integrated with this module.It's very effective and accurate when it comes to find out which sub-domains are active using Nmap and nslookup.

This tool also helps a user in getting the ip addresses of all sub-domains and stores then in a text file , these ip's can be used for further scanning of the target. 

## Screenshots 

![PortWitness](https://raw.github.com/viperbluff/PortWitness/master/screenshots/PortWitness.png)

## Installation 

> **git clone https://github.com/viperbluff/PortWitness.git**

## BASH

This tool has been created using bash scripting so all you require is a linux machine. 

## Usage 

> **Provide execute rights to the file by chmod +x portwitness.sh**

> **bash portwitness.sh url**


## Credits

Sahil Tikoo

Cyber Security Analyst(NII)

sahil.tikoo@niiconsulting.com

