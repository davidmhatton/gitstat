#!/bin/bash

function rollback 
{
    #code
}

function uninstall
{
    echo "Starting uninstall...\n"

    # Get $MYREPOS path and remove from bash profile
    line=grep -n "export MYREPOS=" ~/.bash_profile | cut -f1 -d:
    command="$line"
    command+="d"
    sed -i.bak -e "$command" ~/.bash_profile

    # Delete aliases
    line=grep -n "alias gitstat" ~/.bash_profile | cut -f1 -d:
    command="$line"
    command+="d"
    sed -i.bak -e "$command" ~/.bash_profile

    # Remove project itself
}

OPTIONS="yes no"
select opt in $OPTIONS; do
    if [[ "$opt" == "yes" ]]; then
        uninstall
        exit
    elif [[ "$opt" == "no" ]]; then
        echo "Good job I checked! Aborting uninstall...\n"
        exit
    else echo "Bad entry, please select (1) for yes or (2) for no."
    fi
done