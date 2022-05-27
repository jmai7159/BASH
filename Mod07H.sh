#! /bin/bash


name_array=('Constance_Castillo' 'Kerry_Goodwin' 'Dorothy_Carson' 'Craig_Williams' 
'Daryl_Guzman' 'Sherman_Stewart' 'Marvin_Collier' 'Javier_Wilkerson' 'Lena_Olson' 
'Claudia_George' 'Erik_Elliott' 'Traci_Peters' 'Jack_Burke' 'Jody_Turner' 'Kristy_Jenkins' 
'Melissa_Griffin' 'Shelia_Ballard' 'Armando_Weaver' 'Elsie_Fitzgerald' 'Ben_Evans' 'Lucy_Baker' 
'Kerry_Anderson' 'Kendra_Tran' 'Arnold_Wells' 'Anita_Aguilar' 'Earnest_Reeves' 'Irving_Stone' 
'Alice_Moore' 'Leigh_Parsons' 'Mandy_Perez' 'Rolando_Paul' 'Delores_Pierce' 'Zachary_Webster' 
'Eddie_Ward' 'Alvin_Soto' 'Ross_Welch' 'Tanya_Padilla' 'Rachel_Logan' 'Angelica_Richards' 
'Shelley_Lucas' 'Alison_Porter' 'Lionel_Buchanan' 'Luis_Norman' 'Milton_Robinson' 'Ervin_Bryant' 
'Tabitha_Reid' 'Randal_Graves' 'Calvin_Murphy' 'Blanca_Bell' 'Dean_Walters' 'Elias_Klein' 
'Madeline_White' 'Marty_Lewis' 'Beatrice_Santiago' 'Willis_Tucker' 'Diane_Lloyd' 'Al_Harrison' 
'Barbara_Lawson' 'Jamie_Page' 'Conrad_Reynolds' 'Darnell_Goodman' 'Derrick_Mckenzie' 
'Erika_Miller' 'Tasha_Todd' 'Aaron_Nunez' 'Julio_Gomez' 'Tommie_Hunter' 'Darlene_Russell' 
'Monica_Abbott' 'Cassandra_Vargas' 'Gail_Obrien' 'Doug_Morales' 'Ian_James' 'Jean_Moran' 
'Carla_Ross' 'Marjorie_Hanson' 'Clark_Sullivan' 'Rick_Torres' 'Byron_Hardy' 'Ken_Chandler' 
'Brendan_Carr' 'Richard_Francis' 'Tyler_Mitchell' 'Edwin_Stevens' 'Paul_Santos' 
'Jesus_Griffith' 'Maggie_Maldonado' 'Isaac_Allen' 'Vanessa_Thompson' 'Jeremy_Barton' 
'Joey_Butler' 'Randy_Holmes' 'Loretta_Pittman' 'Essie_Johnston' 'Felix_Weber' 'Gary_Hawkins' 
'Vivian_Bowers' 'Dennis_Jefferson' 'Dale_Arnold' 'Joseph_Christensen' 'Billie_Norton' 
'Darla_Pope' 'Tommie_Dixon' 'Toby_Beck' 'Jodi_Payne' 'Marjorie_Lowe' 'Fernando_Ballard' 
'Jesse_Maldonado' 'Elsa_Burke' 'Jeanne_Vargas' 'Alton_Francis' 'Donald_Mitchell' 'Dianna_Perry' 
'Kristi_Stephens' 'Virgil_Goodwin' 'Edmund_Newton' 'Luther_Huff' 'Hannah_Anderson' 'Emmett_Gill' 
'Clayton_Wallace' 'Tracy_Mendez' 'Connie_Reeves' 'Jeanette_Hansen' 'Carole_Fox' 'Carmen_Fowler' 
'Alex_Diaz' 'Rick_Waters' 'Willis_Warren' 'Krista_Ferguson' 'Debra_Russell' 'Ellis_Christensen' 
'Freda_Johnston' 'Janis_Carpenter' 'Rosemary_Sherman' 'Earnest_Peters' 'Kelly_West' 
'Jorge_Caldwell' 'Moses_Norris' 'Erica_Riley' 'Ray_Gordon' 'Abel_Poole' 'Cary_Boone' 
'Grant_Gomez' 'Denise_Chapman' 'Vernon_Moran' 'Ben_Walker' 'Francis_Benson' 'Andrea_Sullivan' 
'Wayne_Rice' 'Jamie_Mason' 'Jane_Figueroa' 'Pat_Wade' 'Rudy_Bates' 'Clyde_Harris' 'Andre_Mathis' 
'Carlton_Oliver' 'Merle_Lee' 'Amber_Wright' 'Russell_Becker' 'Natalie_Wheeler' 'Maryann_Miller' 
'Lucia_Byrd' 'Jenny_Zimmerman' 'Kari_Mccarthy' 'Jeannette_Cain' 'Ian_Walsh' 'Herman_Martin' 
'Ginger_Farmer' 'Catherine_Williamson' 'Lorena_Henderson' 'Molly_Watkins' 'Sherman_Ford' 
'Adam_Gross' 'Alfred_Padilla' 'Dwayne_Gibson' 'Shawn_Hall' 'Anthony_Rios' 'Kelly_Thomas' 
'Allan_Owens' 'Duane_Malone' 'Chris_George' 'Dana_Holt' 'Muriel_Santiago' 'Shelley_Osborne' 
'Clinton_Ross' 'Kelley_Parsons' 'Sophia_Lewis' 'Sylvia_Cooper' 'Regina_Aguilar' 
'Sheila_Castillo' 'Sheri_Mcdonald' 'Lynn_Hodges' 'Patrick_Medina' 'Arlene_Tate' 'Minnie_Weber' 
'Geneva_Pena' 'Byron_Collier' 'Veronica_Higgins' 'Leo_Roy' 'Nelson_Lopez')

#Search list by first names.
allfirst(){
	#Set counter to 0
	matches=0
	echo
	
	#Ask for name, uppercase input
	read -p "Enter the first name, or a partial start of the first name: " search
	search_name=$(echo $search | tr [:lower:] [:upper:])
	echo 
	
	#For each element in the name array
	for i in ${!name_array[*]};
	do	
		#Compare the name to the i element in the list.
		compare_name=$(echo ${name_array[$i]} | tr [:lower:] [:upper:])
		
		#If the names match, print the name and increment counter	
		if [[ $compare_name == $search_name* ]];then
			echo ${name_array[$i]} | tr "_" " "
			matches=$(($matches+1))
		fi
	done
	
	#If no matches are found, return information.
	if [[ $matches == 0 ]];then
		echo -e "No first names were found starting with $search."
	fi
	echo -e "\nPress Enter to continue"
	read	
}

#Search by last name
alllast(){
	matches=0
	echo
	read -p "Enter the last name, or a partial start of the last name: " search
	search_name=$(echo $search | tr [:lower:] [:upper:])
	echo 
	
	for i in ${!name_array[*]};
	do	
		#Uppercase the full name and split the last name
		compare_name=$(echo ${name_array[$i]} | tr [:lower:] [:upper:])
		declare -a compare_last=()
		compare_last=($(echo $compare_name | cut -d "_" -f 2))
		
		#If the last name equals the search name, print the name.
		if [[ $compare_last == $search_name* ]];then
			echo ${name_array[$i]} | tr "_" " "
			matches=$(($matches+1))
		fi
	done
	if [[ $matches == 0 ]];then
		echo -e "No first names were found starting with $search."
	fi
	echo -e "\nPress Enter to return to the Main Menu"
	read
}

addname(){
	while true;
	do
		#Ask for a first name, check for input.
		read -p "Enter the new first name: " first
		if [[ $first == *" "* ]];then
			echo -e "Just the first name, please. No spaces."
			continue
		fi

		#Ask for last name, check for input
		read -p "Enter the new last name: " last
		if [[ $last == *" "* ]];then
			echo -e "Just the last name, please. No spaces."
			continue
		fi
		
		#Add an underscore and append the information to the array.
		underscore="_"
		name_array+=("$first$underscore$last")
		echo -e "$first $last has been added\n Press Enter to return to the Main Menu"
		read
		break
	done
}

deletename(){
	while true;
	do
		#Provide instruction for delete action.
		echo -e "Delete a name by entering the full name ie: John Smith"
		read -p "Enter the full name (Q to return to the main menu, 1 to search first names): " delete_option

		#Check user input for what action wants to be done.
		if [[ $delete_option == "q" || $delete_option == "Q" ]];then
			break
		elif [[ $delete_option == "1" ]];then
			allfirst
		else
			#Attempt to delete the inputted string from the list
			delete=$(echo $delete_option | tr " " "_")
			for i in ${!name_array[*]};
			do
				if [[ ${name_array[$i]} == $delete ]];then
					name_array=(${name_array[*]:0:$i} ${name_array[*]:$(($i+1))})
				fi
			done
		fi
	done
}





#Main Menu
while true;
do
	clear
	echo -e "Please select from the following options:

	1.  List all names starting with one or more letters of the first name
	2.  List all names starting with one or more letters of the last name
	3.  Add a name
	4.  Delete a name
	5.  Exit\n"
	
	read -p "Option #: " option

	if [[ $option == 1 ]];then
		allfirst
	elif [[ $option == 2 ]];then
		alllast
	elif [[ $option == 3 ]];then
		addname
	elif [[ $option == 4 ]];then
		deletename
	elif [[ $option == 5 ]];then
		break
	else
		echo -e "Invalid option, press Enter to try again."
		read
	fi
done






