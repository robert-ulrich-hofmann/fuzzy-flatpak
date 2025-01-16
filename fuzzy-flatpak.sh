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
        echo "fuzzy-flatpak/fuzzyFind(): Can not find application \"$1\"."
        exit 1
    else
        # remove from string anything-before-and-including-exactly(.var/app/)
        FUZZY_FIND_RESULT=${FUZZY_FIND_RESULT##*.var/app/}
        echo "fuzzy-flatpak/fuzzyFind(): Found $FUZZY_FIND_RESULT"
    fi
}

fuzzyPS()
{
    # substitue the left-most occurence of /\s/ (any whitespace character)
    # with "" (nothing) and print only second ($0 all, $1 first, $2 second)
    # parameter (which are separated by strings) of result
    # input 123 456 com.domain.application org.gnome.Platform
    # result 123456 com.domain.application org.gnome.Platform
    # $2 com.domain.application
    # flatpak ps gives results in lines, awk operates per line
    FUZZY_PS_RESULT=""

    FUZZY_PS_RESULT=$(flatpak ps | awk '{sub(/\s/,"");print $2}')

    if [ -z "$FUZZY_PS_RESULT" ]
    then
        echo "fuzzy-flatpak/fuzzyPS(): No running flatpak processes."
        exit 1
    else
        # todo bug one whitespace character before first result
        echo -e "fuzzy-flatpak/fuzzyPS(): Found running processes:\n" \
                "$FUZZY_PS_RESULT"
    fi
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
                fuzzyPS
                for j in $FUZZY_PS_RESULT
                do
                    flatpak kill "$j"
                done
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
