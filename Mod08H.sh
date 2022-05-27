#! /bin/bash

#Clear console and print message
clear
echo "Processing the pcap file..."

#Write headers
alert_data_headers="Date,Time,Priority,Classification,Description,Source IP, Destination IP"
echo "$alert_data_headers" > alert_data.csv

#Arrays for data
date=()
time=()
priority=()
classification=()
description=()
source=()
destination=()

#Read and cut out required information for alert_data.csv
input=fast_short.pcap
while IFS= read -r line
do
	#Date
	date=$(echo $line | cut -d "-" -f1)

	#Time
	time=$(echo $line | cut -d "-" -f2)
	time=$(echo $time | cut -d " " -f1)

	#Priority
	priority=$(echo $line | cut -d "*" -f5)
	priority=$(echo $priority | cut -d "[" -f3)
	priority=$(echo $priority | cut -d " " -f2)
	priority=$(echo $priority | cut -d "]" -f1)

	#Classification
	classification=$(echo $line | cut -d "*" -f5)
	classification=$(echo $classification | cut -d "[" -f2)
	classification=$(echo $classification | cut -d ":" -f2)
	classification=$(echo $classification | cut -d "]" -f1)	
	
	#Description
	description=$(echo $line | cut -d "*" -f3)
	description=$(echo $description | cut -d "]" -f3)
	description=$(echo $description | cut -d "[" -f1)
	
	#Source IP
	source=$(echo $line | cut -d "*" -f5)
	source=$(echo $source | tr "}" "|")
	source=$(echo $source | cut -d "|" -f2)
	source=$(echo $source | cut -d " " -f1)

	#Destination IP	
	destination=$(echo $line | cut -d "*" -f5)
	destination=$(echo $destination | tr "}" "|")
	destination=$(echo $destination | cut -d "|" -f2)
	destination=$(echo $destination | cut -d " " -f3)
	
	#Write output to alert_data.csv
	output="$date,$time,$priority,$classification,$description,$source,$destination"
	echo $output >> alert_data.csv

done < $input

#Close script
clear
echo "The pcap file has been processed"









