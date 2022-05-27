#!/bin/sh

#Declare and fill the four suits for the deck
declare -a spades=('Ace_of_Spades' 'King_of_Spades' \
'Queen_of_Spades' 'Jack_of_Spades' \
'10_of_Spades' '9_of_Spades' \
'8_of_Spades' '7_of_Spades' \
'6_of_Spades' '5_of_Spades' \
'4_of_Spades' '3_of_Spades' \
'2_of_Spades')

declare -a diamonds=('Ace_of_Diamonds' 'King_of_Diamonds' \
'Queen_of_Diamonds' 'Jack_of_Diamonds' \
'10_of_Diamonds' '9_of_Diamonds' \
'8_of_Diamonds' '7_of_Diamonds' \
'6_of_Diamonds' '5_of_Diamonds' \
'4_of_Diamonds' '3_of_Diamonds' \
'2_of_Diamonds')

declare -a clubs=('Ace_of_Clubs' 'King_of_Clubs' \
'Queen_of_Clubs' 'Jack_of_Clubs' \
'10_of_Clubs' '9_of_Clubs' \
'8_of_Clubs' '7_of_Clubs' \
'6_of_Clubs' '5_of_Clubs' \
'4_of_Clubs' '3_of_Clubs' \
'2_of_Clubs')

declare -a hearts=('Ace_of_Hearts' 'King_of_Hearts' \
'Queen_of_Hearts' 'Jack_of_Hearts' \
'10_of_Hearts' '9_of_Hearts' \
'8_of_Hearts' '7_of_Hearts' \
'6_of_Hearts' '5_of_Hearts' \
'4_of_Hearts' '3_of_Hearts' \
'2_of_Hearts')


declare -a gameSpades=()
declare -a gameDiamonds=()
declare -a gameClubs=()
declare -a gameHearts=()

#Draw a card from the deck
option1_func () {
	clear
	
	#Get user input and verify a valid input is provided
	read -p "How many cards would you like to draw from this deck? " cardRequest
	if ! [[ $cardRequest =~ ^[+]?[0-9]+$ ]] 2>>/dev/null;then
		echo
		echo -e "You have entered an invalid input. Press Enter to try again."
		read
		return	
	fi
	
	#Cards remaining tracks how many cards are left in the current deck
	cardsRemaining=$((${#gameSpades[*]}+${#gameDiamonds[*]}+${#gameClubs[*]}+${#gameHearts[*]}))
	
	#Check if the user is overdrawing cards
	if [[ $cardRequest -gt $cardsRemaining ]];then
		clear
		echo -e "There are only $cardsRemaining left in the deck but you have requested $cardRequest cards."
		echo
		read -p "Press the Enter key to return to the main menu: "
		return
	fi
	
	#Draw the cards
	echo "Your cards are:"
	echo
	while [[ $cardRequest -ne 0 ]];
	do
		#Request a random suit
		variableSuit=$(($RANDOM%4))
		
		#Draw Spades
		if [[ $variableSuit == 0 ]];then
			suitLength=${#gameSpades[*]}
			
			#If there are no spades
			if [[ $suitLength == 0 ]];then
				spades_gone=1
				continue
			
			#Draw a card from spades
			else
				card=$(($RANDOM%$suitLength))
				echo ${gameSpades[$card]}
				gameSpades=(${gameSpades[*]:0:$card} ${gameSpades[*]:$(($card + 1))})
				cardRequest=$(($cardRequest-1))
			fi
			
		#Draw Diamonds
		elif [[ $variableSuit == 1 ]];then
			suitLength=${#gameDiamonds[*]}
			
			#If there are no Diamonds
			if [[ $suitLength == 0 ]];then
				diamonds_gone=1
				continue
			
			#Draw a card from diamonds
			else
				card=$(($RANDOM%$suitLength))
				echo ${gameDiamonds[$card]}
				gameDiamonds=(${gameDiamonds[*]:0:$card} ${gameDiamonds[*]:$(($card + 1))})
				cardRequest=$(($cardRequest-1))
			fi
		
		#Draw Clubs
		elif [[ $variableSuit == 2 ]];then
			suitLength=${#gameClubs[*]}
		
			#If there are no Clubs
			if [[ $suitLength == 0 ]];then
				clubs_gone=1
				continue
	
			#Draw a card from clubs
			else
				card=$(($RANDOM%$suitLength))
				echo ${gameClubs[$card]}
				gameClubs=(${gameClubs[*]:0:$card} ${gameClubs[*]:$(($card + 1))})
				cardRequest=$(($cardRequest-1))
			fi
		
		#Draw Hearts
		else
			suitLength=${#gameHearts[*]}
			
			#If there are no hearts
			if [[ $suitLength == 0 ]];then
				hearts_gone=1
				continue
			
			#Draw a card from hearts
			else
				card=$(($RANDOM%$suitLength))
				echo ${gameHearts[$card]}
				gameHearts=(${gameHearts[*]:0:$card} ${gameHearts[*]:$(($card + 1))})
				cardRequest=$(($cardRequest-1))
			fi
		fi	
	done
	echo
	echo "Press Enter to continue"
	read
}


#Get a new deck
option2_func () {
	#Copy the array of cards into the game deck
	gameSpades=(${spades[*]})
	gameDiamonds=(${diamonds[*]})
	gameClubs=(${clubs[*]})
	gameHearts=(${hearts[*]})
	
	#Reset gone status
	spades_gone=0
	diamonds_gone=0
	clubs_gone=0
	spades_gone=0
}


#Initial game deck and status
gameSpades=(${spades[*]})
gameDiamonds=(${diamonds[*]})
gameClubs=(${clubs[*]})
gameHearts=(${hearts[*]})
spades_gone=0
diamonds_gone=0
clubs_gone=0
spades_gone=0



#Main Menu
while true;
do
	clear
	echo -e "Welcome to the card deck simulator."
	echo
	echo -e "Please select from the following options:"
	echo
	echo -e "	1. Draw a selected number of cards from the current deck"
	echo -e "	2. Get a new deck of cards"
	echo -e "	3. Exit"
	echo
	read -p "Option#: " userOption
	
	if [[ $userOption == 1 ]];then
		option1_func
	elif [[ $userOption == 2 ]];then
		option2_func
	elif [[ $userOption == 3 ]];then
		break
	else
		echo -e "That is not a valid option. Please try again."
		read
	fi
done
