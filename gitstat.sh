#!/bin/bash

#this function takes a directory as an input parameter
function gitcheck {
    if  [[ "$PWD" != "$MYREPOS/go" ]]; then
        cd $1 && git branch -vv
    else
        printf "\033[0;94mSkip Go Repository\033[0m\n"
    fi
}

function gitfetch {
    if [[ "$PWD" != "$MYREPOS/go" ]]; then
        cd $1 && git fetch --all --prune
    else
        printf "\033[0;94mSkip Go Repository\033[0m\n"
    fi
}

###
# Handler Function
# $1 - action: either "stat" or "fetch"
# $2 - repo
#
function handler {
	cd $2
	printf "\033[1;36m$(pwd)\033[0m\n"
	case $1 in
		stat )
			gitcheck .
		;;
		fetch )
			gitfetch .
		;;
		* )
			echo "Invalid input to handler funciton: $1"
		;;
	esac
	cd ..
	echo ""
}

choice=$1
origin=$(pwd)
cd $MYREPOS
repolist=$(ls -d */)

if [ -z $choice ]; then
    echo "Select an action for the repositories:\n[1] Status Update\n[2] Fetch and Prune"
    read chosen
    choice=$chosen
fi

case $choice in
    1 )
        for repo in $repolist; do
			handler stat $repo
        done
		handler stat $MYREPOS/moodledocker/turnitintool
		handler stat $MYREPOS/moodledocker/turnitintooltwo
        ;;
    2 )
        for repo in $repolist; do
			handler fetch $repo
        done
		handler fetch $MYREPOS/moodledocker/turnitintool
		handler fetch $MYREPOS/moodledocker/turnitintooltwo
		;;
    * )
		echo "Invalid choice input: $choice. Please try again."
		;;
esac
cd $origin
