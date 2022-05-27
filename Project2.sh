#! /bin/sh

#Variable Declarations
good_urls=()
bad_urls=()
master_urls=()
dircheck=~/URLs
project_files_check=Project_Files.tar.gz
bad_URLs_files=~/URLs/Bad_URLs/Bad_URLs.txt
mixed_URLs_files=~/URLs/Mixed_URLs/Mixed_URLS.txt
temp_file=~/URLs/Temp
URL_master_file=~/URLs/URL_Master_File.txt

cd

#Startup function
startup() {
	clear
	#Checks for URL directory and removes recusively if found.
	if [[ -d $dircheck ]];then		
		rm -r ~/URLs
	fi

	#Check if Project files is in the directory, unpack if found.
	if ! [[ -f "$project_files_check" ]];then
		echo -e "Place Project_Files.tar.gz in the home directory then run this script again."
		read -p "Press Enter to exit the script."
		exit
	else
		tar -xf Project_Files.tar.gz
	fi
}

startup


option1() {
	clear
	
	#If files are not available, close function.
	if ! [[ -f "$mixed_URLs_files" ]];then
		read -p "There are no more mixed URL files. Press Enter to continue."
		return
	fi
	
	#Read mixed URL file and test the link to see if it is live or dead.
	while IFS= read -r line
	do
		mixed_URL=$(echo "$line" | sed 's/http/|/g')
		mixed_URL=$(echo "$mixed_URL" | cut -d "|" -f2)
		length_mixed_URL=$((${#mixed_URL}-2))
		mixed_URL=${mixed_URL:0:$length_mixed_URL}
		mixed_URL="http$mixed_URL"

		#Test URL, write live URLs to temp and dead files to bad URLs
		status=$(curl --connect-timeout 5 -s -o /dev/null -w "%{http_code}\n" $mixed_URL)		
		if [[ status -lt 400 && status -ne 0 ]];then
			echo -e "$mixed_URL is up with code $status"
			echo -e "$mixed_URL is up with code $status" >> $temp_file/temp.txt
		else
			echo -e "$mixed_URL is down with code $status"
			echo -e "$mixed_URL is down with code $status" >> ~/URLs/Bad_URLs/Bad_URLs_2.txt
		fi
	done < $mixed_URLs_files
	
	#Build master file array
	echo -e "\nBuilding master file array"
	while IFS= read -r line
	do
		master_URL=$(echo "$line" | tr "_" "*")
		master_URL=$(echo "$master_URL" | tr "\t" "|")
		master_URL=$(echo "$master_URL" | tr " " "_")
		master_urls+=($master_URL)

	done < $URL_master_file
	
	#Build good URL file array
	echo -e "Building good url file array"
	while IFS= read -r line
	do
		good=$(echo "$line" | tr "_" "*")
		good=$(echo "$good" | tr "\t" "|")
		good=$(echo "$good" | tr " " "_")
		good_urls+=($good)

	done < $temp_file/temp.txt
	
	#Combine arrays
	echo -e "Adding good urls to master url array"
	master_urls+=(${good_urls[*]})

	#Sort array and eliminate duplicates.
	echo -e "Sorting master url file array and eliminating duplicates"
	master_urls=($(
		for i in ${master_urls[*]};
		do
			echo "$i"
		done | sort -u ))
		
	#Write master array to text file.
	echo -e "Writing master url array to file"
	echo "Primary Category	Secondary Category	Title	URL" > $temp_file/temp.txt
	for i in ${master_urls[*]};
	do	
		final_url=$(echo "$i" | tr "_" " ")
		final_url=$(echo "$final_url" | tr "|" "\t")
		final_url=$(echo "$final_url" | tr "*" "_")
		echo -e "$final_url" >> $temp_file/temp.txt
	done
	echo
	mv $temp_file/temp.txt $URL_master_file
	mv $mixed_URLs_files ~/URLs/Mixed_URLs/Processed_Mixed_URLS/Mixed_URLS.txt
	
	read -p "Mixed URL file processing is complete. Press Enter to continue."
	good_urls=()
	master_urls=()
}

option2() {
	clear

	#Check if files are available
	if ! [[ -f "$bad_URLs_files" ]];then
		read -p "Bad_URLs.txt has been processed. Press Enter to continue."
		return
	fi
	
	#Build bad URL array
	echo -e "Building bad url array"
	while IFS= read -r line
	do
		bad=$(echo "$line" | tr "_" "*")
		bad=$(echo "$bad" |tr "\t" "|")
		bad=$(echo "$bad" |tr " " "_")
				
		bad_urls+=($bad)
	done < $bad_URLs_files

	#Build master file array
	echo -e "Building master file array"
	while IFS= read -r line
	do
		master_URL=$(echo "$line" | tr "_" "*")
		master_URL=$(echo "$master_URL" | tr "\t" "|")
		master_URL=$(echo "$master_URL" | tr " " "_")
		
		master_urls+=($master_URL)

	done < $URL_master_file

	#Remove bad URLs from master array
	echo -e "Removing bad urls from master array"
	for i in ${!master_urls[*]};
		do
			for j in ${!bad_urls[*]};
				do
					if [[ "${master_urls[$i]}" == "${bad_urls[$j]}" ]];then
						master_urls=(${master_urls[*]:0:$i} ${master_urls[*]:$(($i+1))})
					fi
				done
		done
	
	#Sort master file array
	echo -e "Sorting master url file array"	
	master_urls=($(
		for i in ${master_urls[*]};
		do
			echo "$i"
		done | sort))
	
	#Rewrite updated master array file
	echo -e "Writing master url array to file"
	echo "Primary Category	Secondary Category	Title	URL" > $URL_master_file
	for i in ${master_urls[*]};
	do	
		final_url=$(echo "$i" | tr "_" " ")
		final_url=$(echo "$final_url" | tr "|" "\t")
		final_url=$(echo "$final_url" | tr "*" "_")
		echo -e "$final_url" >> $URL_master_file
	done		

	mv $bad_URLs_files ~/URLs/Bad_URLs/Processed_Bad_URLs/Bad_URLs.txt
	bad_urls=()
	master_urls=()	
	read -p "Bad URL file processing is complete. Press Enter to continue."
}

option3() {
	clear
	master_urls=()

	#Build master file array
	echo -e "Building master file array"
	while IFS= read -r line
	do
		master_URL=$(echo "$line" | tr "_" "*")
		master_URL=$(echo "$master_URL" | tr "\t" "|")
		master_URL=$(echo "$master_URL" | tr " " "_")
		
		master_urls+=($master_URL)

	done < $URL_master_file

	#Search for related titles.
	while true;
		do
			read -p "Enter all or part of a title: " search
			search=$(echo "$search" | tr [:lower:] [:upper:])
			search=$(echo "$search" | tr " " "_")
			for i in ${!master_urls[*]};
			do	
				title=$(echo "${master_urls[$i]}" | cut -d "|" -f3)
				title_match=$(echo "$title" | tr [:lower:] [:upper:])
				url=$(echo "${master_urls[$i]}" | cut -d "|" -f4)
				
				if [[ $title_match == *$search* ]];then
					title=$(echo "$title" | tr "_" " ")
					title=$(echo "$title" | tr "|" "\t")
					title=$(echo "$title" | tr "*" "_")
					
					
					result="$title\t$url"
					echo -e "$result"
				fi

			done


			read -p "Press enter to search again or Q to return to the main menu: " option3input	
			option3input=$(echo "$option3input" | tr [:lower:] [:upper:])
			if [[ $option3input == Q ]];then
				return
			fi



		done
	master_urls=()
}







while true;
do
	clear
	echo "----- MAIN MENU -----
Please select from the following options:

1. Process Mixed URLs
2. Process Bad URLs
3. Look up URLs by Title
4. Exit
"
	read -p "Option#: " option
	
	if [[ $option == 1 ]];then
		option1
	elif [[ $option == 2 ]];then
		option2
	elif [[ $option == 3 ]];then
		option3
	elif [[ $option == 4 ]];then
		clear
		break
	else
		read -p "Invalid selection. Please press enter to try again."
	fi
done













