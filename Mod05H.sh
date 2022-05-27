#!/bin/sh
clear

#Variable Declarations
total_payment=0
base_price=100
price_variance=$(($RANDOM%4*5))
soda_price=$((base_price + $price_variance))

#Ask for user input
echo -e "Welcome to the soda machine. You can enter values of 5, 10 or 25 in payment.\n"
read -p "What type of soda would you like? " soda_name

echo -e "\nThe current price of $soda_name is $soda_price cents\n"

#Vending Machine Logic
while true;
	do

	#Get User Input
	read -p "Enter a coin: " user_payment
	
	#Coin logic	
	if [[ $user_payment -eq 5 ]];then
		echo -e "You have inserted a nickel."
		total_payment=$(($total_payment + $user_payment))

	elif [[ $user_payment -eq 10 ]];then
		echo -e "You have inserted a dime."
		total_payment=$(($total_payment + $user_payment))

	elif [[ $user_payment -eq 25 ]];then
		echo -e "You have inserted a quarter."
		total_payment=$(($total_payment + $user_payment))		

	else
		echo -e "That is not a valid amount."
	fi
	
	#Track the balance
	balance=$(($soda_price - $total_payment))
	
	#Check to see if have completed payment and owe money
	if [[ $balance -gt 0 ]];then
		echo -e "You still owe $balance cents.\n"

	elif [[ $balance -lt 0 ]];then
		balance=$(($balance * -1))
		echo -e "\nYou have been refunded $balance cents.\n"
		break
	else
		break

	fi		
	done

#Close
echo -e "Your $soda_name is being dispensed. Thank you!\n"
read -p "Press the enter key to close the script"

