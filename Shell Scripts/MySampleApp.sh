#!/bin/sh

clear
echo ""
echo "$(tput setaf 3)=====Let's Get started====="
echo "$(tput setaf 7)"

# File-Management
File_Opeartion () {
while :
do
    echo "$(tput setaf 2)"
    echo "\n\nChoose a option"
    printf "1.Write into a file\n2.Append content\n3.Read data from file\n4.Delete file\n5.Back"
    echo "$(tput setaf 7)"
    echo ""
    echo "Enter your choice : "
    read  UserChoice
    if [ $UserChoice -eq 5 ]
    then 
        break
    elif [ $UserChoice -eq 1 ]
    then
        echo 
        echo "Enter text into your file"
        read FileValue
        echo $FileValue > data.txt
        echo
        echo "File is Created & Data is written!!"
        echo
    elif [ $UserChoice -eq 2 ]
    then
        echo 
        echo "Enter text into your file"
        read FileValue
        echo $FileValue >> data.txt
        echo 
        echo "Data is written!!"
    elif [ $UserChoice -eq 3 ]
    then
        
        if [ -f "data.txt" ]
        then
            echo ""
            echo "Data : "
            cat data.txt
            echo 
        else
            echo 
            echo "$(tput setaf 1)File doesn't exist"
            echo "$(tput setaf 7)"
        fi
    elif [ $UserChoice -eq 4 ]
    then
        if [ -f "data.txt" ]
        then
            sudo rm data.txt
            echo "File Deleted!!"
        else
            echo "$(tput setaf 1)File doesn't exist"
            echo "$(tput setaf 7)"
        fi 
    fi
done
}

# Services Infotmation
Services_Info () {
while :
do
    echo "$(tput setaf 2)"
    echo "\n\nChoose a option to know Services which are"
    printf "1.Running\n2.Not Running\n3.Back"
    echo "$(tput setaf 7)"
    echo ""
    echo "Enter your choice : "
    read  UserChoice
    if [ $UserChoice -eq 1 ]
    then
        echo
        echo "Services which are running are : "
        echo
        service --status-all | grep '\[ + \]'
    elif [ $UserChoice -eq 2 ]
    then
        echo
        echo "Services which are not running are : "
        echo
        service --status-all | grep '\[ - \]'
    elif [ $UserChoice -eq 3 ]
    then
        break
    fi
done
}

# Guessing - Game
Guessing_Game (){
echo "$(tput setaf 0)"
computer=$(( ( RANDOM % 10 ) ))
echo "$(tput setaf 7)"
while :
do
    echo "Enter your number : "
    read user
    if [ $computer -eq $user ]
    then
        echo 
        echo "$(tput setaf 3)Congratulations!! You Won.."
        echo "$(tput setaf 7)"
        break
    elif [ $user -lt $computer ]
    then
        echo "$(tput setaf 1)Sorry mate! Too Low"
        echo "$(tput setaf 7)"
    elif [ $user -gt $computer ]
    then
        echo "$(tput setaf 1)Sorry mate! Too High"
        echo "$(tput setaf 7)"
    elif [ $i -gt 5 ]
    then
        echo "$(tput setaf 1)Sorry mate! You are Out of Attempts!!"
        echo "$(tput setaf 7)"
    fi
done
echo "$(tput setaf 5)Game Ended!!"
echo "$(tput setaf 7)"
}

# Main Code

while :
do
    echo "$(tput setaf 2)"
    printf "Choose a Option:\n1.File Operations\n2.Services Information\n3.Guessing - Game\n4.Close\n"
    echo "$(tput setaf 7)"
    echo "Enter your choice : "
    read UserChoice

    case $UserChoice in 
        1) File_Opeartion
        ;;
        2) Services_Info
        ;;
        3) Guessing_Game
        ;;
        4) break
    esac
done