#!/bin/bash -

# Make some flatpak commands accept fuzzy names

fuzzyFlatpakCommands=("help" "info" "run" "kill")

checkIfNameProvided()
{
    if [[ ! $1 ]]
    then
        echo "fuzzy-flatpak: You need to provide a name." \
             "Run \"fuzzy-flatpak help\" for help."
        exit 1
    fi
}

fuzzyFind()
{
    FUZZY_FIND_RESULT=""

    # -maxdepth 1 just on given level, don't go deeper (lot's of duplicates)
    # -type d = directory
    # -iname ignores case as opposed to -name
    # -print -quit just prints first result and ends find
    FUZZY_FIND_RESULT=$(find "$HOME/.var/app" -maxdepth 1    \
                                              -type d        \
                                              -iname "*$1*"  \
                                              -print         \
                                              -quit          \
    )

    if [ -z "$FUZZY_FIND_RESULT" ]
    then
        echo "fuzzy-flatpak/fuzzy-find(): Can not find application \"$1\""
        exit 1
    else
        # remove from string anything-before-and-including-exactly(.var/app/)
        FUZZY_FIND_RESULT=${FUZZY_FIND_RESULT##*.var/app/}
        echo "fuzzy-flatpak/fuzzy-find(): Found $FUZZY_FIND_RESULT"
    fi
}

getRunningProcesses()
{
    echo "getRunningProcesses"
    # get all running processes as names
    # return array
}

if [[ ! $(command -v flatpak) ]]
then
    echo "fuzzy-flatpak: Flatpak not found. You need to install flatpak for" \
         "fuzzy-flatpak to work."
    exit 1
fi

if [ ! "$1" ]
then
    echo "fuzzy-flatpak: You need to provide a command." \
         "Run \"fuzzy-flatpak help\" for help."
    exit 1
fi

# command part of fuzzy-flatpak
for i in "${fuzzyFlatpakCommands[@]}"
do
    if [[ $1 == "$i" ]]
    then
        if [ "$1" == "help" ]
        then
            # todo
            echo "help"
            exit 0
        elif [ "$1" == "info" ]
        then
            # pass the script arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak info "$FUZZY_FIND_RESULT"
            exit 0
        elif [ "$1" == "run" ]
        then
            # pass the script arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak run "$FUZZY_FIND_RESULT"
            exit 0
        elif [ "$1" == "kill" ]
        then
            if [[ ! $2 ]]
            then
                echo "kill all"
                exit 0
            else
                fuzzyFind "$2"
                flatpak kill "$FUZZY_FIND_RESULT"
                exit 0
            fi
        fi
    fi
done

# command not part of fuzzy-flatpak
echo "fuzzy-flatpak: Command \"$1\" not recognized." \
     "Run \"fuzzy-flatpak help\" for help."
exit 1
