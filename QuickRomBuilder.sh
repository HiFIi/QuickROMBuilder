#!/bin/bash

# Make sure to put me in the 'build' folder!

# Run me by entering:
# . build/QuickRomBuilder.sh

###############################################################
#                                                             #
#                                                             #
# The purpose of this is to make ROM building quick and easy. #
#                                                             #
#                                                             #
###############################################################

# If you'd like to shorten the name of the file, simply rename it and
# Run . build/WhateverName.sh

FILE="/tmp/out.$$"
GREP="/bin/grep"

# Source for those above 2:
# http://www.cyberciti.biz/tips/shell-root-user-check-script.html

ROMConfig="quickrombuild"

# dateText="Today's Date"

DaySuffix() {
  case `date +%d` in
    1|21|31) echo "st";;
    2|22)    echo "nd";;
    3|23)    echo "rd";;
    *)       echo "th";;
  esac
}

# Source for the above code:
# http://stackoverflow.com/a/21370675/3803515

todaysDate= $(date +"%B %d`DaySuffix`, %Y")

# $url=http://reinvented.t15.org/ChangelogGUI.sh

# writeFile() {

# wget "http://reinvented.t15.org/ChangelogGUI.sh"

# }


welcomeDisplay () {
clear

sleep 0.5
echo "############################################################"
sleep 0.5
echo "#                                                          #"
sleep 0.5
echo "#                                                          #"
sleep 0.5
echo "#                   | --------------- |                    #"
sleep 0.5
echo "#                   |   Welcome to:   |                    #"
sleep 0.5
echo "#                   |                 |                    #"
sleep 0.5
echo "#                   | QuickROMBuilder |                    #"
sleep 0.5
echo "#                   | --------------- |                    #"
sleep 0.5
echo "#                                                          #"
sleep 0.5
echo "#                                                          #"
sleep 0.5
echo "############################################################"
sleep 0.5

sleep 3

}
# My original code
askUserToRoot () {
# echo " "
echo "Would you like to run as root?"
echo " "
echo "Enter yes or no, followed by [ENTER]"
echo " "

read Answer

if [ $Answer = "yes" ]
   then echo "Okay!"
   echo "Initiating..."
   sleep 1.5
   echo " "
   echo "Please cd into the correct folder and re-run this after going root!"
   echo " "
   sleep 2
   sudo -i
# fi
elif [ $Answer = "no" ]
   then echo " "
   echo "Exiting..."
   sleep 2
   exit 1
fi

}

forceBrokenCheck () {
   echo "--force-broken ?"
   echo " "
   echo "Enter yes or no, followed by [ENTER]"
   
   read ForceBrokenYesOrNo

   if [ $ForceBrokenYesOrNo = "yes" ]
   then echo "-f"
   fi

   if [ $ForceBrokenYesOrNo = "no" ]
     then echo " "
     # ^ Basically, do nothing
   fi
}

optionChosenMka () {
cd build
if [ ! -d QuickRomBuilderScripts ]
then echo " "
echo "QuickRomBuilderScripts folder not found! :o"
echo "Don't worry though. I'm creating it for you now."
sleep 2
mkdir QuickRomBuilderScripts
chmod 777 -R QuickRomBuilderScripts
echo "Done! See how easy that was?"

elif [ -d QuickRomBuilderScripts ];
then echo " "
echo "Script folder found! Continuing..."
echo " "
sleep 1.5
fi

cd ..

# "mka bacon -j$jobsPerThread"
#  echo -ne '\n'
}

optionChosenMka () {

mka bacon -j$jobsPerThread
echo -ne '\n'

}

optionChosenMake () {
cd build
if [ ! -d QuickRomBuilderScripts ]
then mkdir QuickRomBuilderScripts

elif [ -d QuickRomBuilderScripts = true];
then echo "Script folder found! Continuing..."
echo " "
sleep 1.5
fi

cd ..
# "make -j$jobsPerThread"
# echo -ne '\n'
}

showBuildInfo () {
clear

# echo "Building a ROM for the $DEVICE..."
echo " "
sleep 3

}

jobsPerThreadRepoSync () {
   echo "How many jobs per thread should we repo sync with?"
   read JobsPerThreadRepoSync
}

askToRepoSync () {
clear
# echo " "
echo "Would you like to repo sync before getting started?"
echo " "

echo "enter yes or no, followed by [ENTER]"
echo " "

read askToRepoSyncAnswer

if [ $askToRepoSyncAnswer == "yes" ]
then echo " "
echo "Please specify how many jobs per thread you'd like to use when repo syncing,"
echo "followed by [ENTER]"
echo " "

read jobsPerThreadRepoSync

# $jobsPerThreadRepoSync=$jobsPerThread
sleep 2
echo " "
echo "Repo syncing ( with --force-broken, and using $jobsPerThreadRepoSync jobs per thread)"
sleep 1.75

repo sync -f -j$jobsPerThreadRepoSync

echo -ne '\n'

elif [ $askToRepoSyncAnswer == "no" ]
then echo " "
echo "Okay. Continuing..."
echo " "
sleep 1.75
fi

}

checkForSudo () {
echo "Checking for root..."
echo " "
sleep 1.5

# Make sure only root can run our script
if [ "$(id -u)" != "0" ];
   then echo " "
   echo "This script must be run as root" 1>&2
   echo " "
   askUserToRoot
#  echo "Exiting..."
#  sleep 2
#  exit 1
elif [ "$(id -u)" != "1" ];
   then echo "Root found!"
   sleep 1.5
   echo " "
   echo "Continuing..."
#  echo " "
   sleep 1.5
   
fi

# Source: http://www.cyberciti.biz/tips/shell-root-user-check-script.html
# Edited by me though to fix an error and add a line of code

}

checkForChangelogFolder () {
if [ ! -d build/Changelog ]
   then echo "Creating a Changelog folder..."
   sleep 2
   cd build
   mkdir Changelogs
   chmod 777 -R Changelogs
   cd ..
   echo "Done! Continuing..."
   echo " "
   sleep 1.5
fi
}

startBuilding () {
. build/envsetup.sh
lunch "$chosenDeviceNumber" # -j$jobsPerThread
mka bacon -j$jobsPerThread
}

showBuildStuff () {
# echo " "
clear
echo "Starting the build for $TARGET_PRODUCT..."
sleep 2

startBuilding

}

buildInitiate () {
echo " "
echo "Please enter the number of the device you'd like to build for: "

read chosenDeviceNumber

# $chosenDeviceNumber=$chosenDeviceNumber

echo " "
echo "Please enter how many jobs per thread you'd like to build with: "

read jobsPerThread

echo " "
# echo "Please enter mka or make: "

# read mkaOrmake

# if [ $mkaOrmake = "mka" ]
   # then optionChosenMka
#  then echo "mka bacon -j$jobsPerThread"
#  echo -ne '\n'
   
# elif [ $mkaOrMake = "make" ]
# then optionChosenMake
# fi

clear

echo "Initiating build..."
echo " "
sleep 2

showBuildStuff

# showBuildInfo

# . build/envsetup.sh
# lunch "$chosenDeviceNumber" # -j$jobsPerThread
# echo "$TARGET_PRODUCT"
# mka bacon -j$jobsPerThread
# echo -ne '\n'

}

askToPullChangelog () {
echo " "
echo "Would you like to pull a changelog from today?"
echo " "
echo "Enter yes or no, followed by [ENTER]"
echo " "

read changelogYesOrNo

if [ $changelogYesOrNo = "yes" ]
   # echo " "
   then echo "Okay!"
   echo " "
   checkForChangelogFolder
   clear
   
   echo "Pulling a changelog from today..."
   echo " "
#  echo "Today's date: "
#  echo "$todaysDate"
   sleep 2
   cd build
   cd Changelogs
   mkdir -p $(date +"%m-%d-%Y")
   cd $(date +"%m-%d-%Y")
   repo forall -pc git log --reverse --no-merges --since=1.day.ago > ROM-Changelog-$(date +"%m-%d-%Y").txt
   cd ..
   cd ..
   cd ..
   
fi

if [ $changelogYesOrNo = "no" ]
elif [ $askToRepoSyncAnswer == "no" ]
then echo " "
echo "Okay. Continuing..."
echo " "
   sleep 2
fi  

}


# WIP
# checkIfChangelogExists () {
# if [ -e ChangelogGUI.sh ]
#    then echo "FOUND IT"

# elif [ ! -e ChangelogGUI.sh ]
#    then echo "Should I download my ChangelogGUI script?"
# }

# changeLoggerStuff () {
# echo "Would you like to download a modified version of my ChangelogGUI script?"
# echo "Enter yes or no, followed by [ENTER] "

# read changelogScriptAnswer

# if [ $changelogScriptAnswer == "yes" ]
#    then checkIfChangelogExists
#    fi
# }



# clear

# writeFile

# echo "Hello $USER!"
# echo " "
# sleep 2

# echo " "

# echo "Checking for root..."
# echo " "
# sleep 1.5

# Show the neat little welcome display thing
welcomeDisplay

# Check if user is running this as root
checkForSudo

# Ask if the user would like to quickly repo sync
askToRepoSync

# Ask the user if they want to pull a changelog from today
askToPullChangelog


# WIP:
# THIS is the newer, more logical code. :)
# changeLoggerStuff

# Initiate the rest of the stuff
buildInitiate


# QuickRomBuilder
# Version 1.1

# Made by Kyler Jeffrey, aka 'I Am Reinvented' (https://github.com/I-am-Reinvented/)
# Feel free to use this as you please, just make sure to give the proper credit. :)

# initially created on August 20th, 2014
