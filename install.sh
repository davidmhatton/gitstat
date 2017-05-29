#!/bin/bash

echo "Setting up tool with central repo directory...\n"

# Discern whether there is already a $MYREPOS set.
if [[ -z ${MYREPOS+x} ]]; then 
    # Set it up
    echo "no variable \"\$MYREPOS\" detected.\nPlease enter a path to the folder containing your git repositories:"
    read repoPath
    echo "export MYREPOS=$repoPath" >> ~/.bash_profile
    source ~/.bash_profile

    # check it
    if [[ -n $MYREPOS ]]; then echo "directory variable setup successful"
    else echo "there was a problem setting up variable \"\$MYREPOS\"."
    fi
else 
    if [[ -d $MYREPOS ]]; then
        echo "There is already an exported variable \"\$MYREPOS\", currently set to $MYREPOS.\nWould you like to use this variable as the main repository?"
        OPTIONS="yes no"
        select opt in $OPTIONS; do
            if [[ "$opt" == "yes" ]]; then
                echo "OK, let's do it."
                break
            elif [[ "$opt" == "no" ]]; then
                echo "That variable name is required. Try renaming that variable to something else and starting again.\n"
                exit
            else echo "Bad entry, please select (1) for yes or (2) for no."
            fi
        done
    else
        echo "There is already an exported variable \"\$MYREPOS\", but it is not a directory. That variable is required for setup and config./nTry renaming that variable and starting again."
    fi
fi

# Get other directories to use
echo "Are there any other repositories that you wish to include for use by this tool?"
select opt in $OPTIONS; do
    if [[ "$opt" == "yes" ]]; then
        # Write directories 
        echo "Please enter any extra directories to include that are not in the parent directory covered by \$MYREPOS.\nEnter full paths, separated by spaces."
        read extrasString
        extras=($extrasString)
        printf "%s\n" ${extras[@]} > ./lib/extras.txt
        break
    elif [[ "$opt" == "no" ]]; then
        echo "" > ./lib/extras.txt
        echo "Setup complete."
        break
    else echo "Bad entry, please select (1) for yes or (2) for no."
    fi
done

# Discern whether the command alias is set.
if grep -Fxq "alias gitstat" ~/.bash_profile
then
    echo "Alias already set"
else
    thisDir=$(pwd)
    echo "alias gitstat='sh $thisDir/gitstat.sh'" >> ~/.bash_profile
    source ~/.bash_profile
    echo "Alias has been set - use command 'gitstat' to run the program."
fi