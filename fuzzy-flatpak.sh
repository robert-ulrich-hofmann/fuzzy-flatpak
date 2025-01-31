#!/bin/bash -

# fuzzy-flatpak: Make some flatpak commands accept fuzzy names

FUZZY_FLATPAK_COMMANDS=("help" "-h" "--help"
                      "info"
                      "run"
                      "kill"
                      "kill-all"
                      "update"
)

FUZZY_NAMES=()

FUZZY_OPTIONS=()

FUZZY_FIND_RESULTS=()

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
    # -iname ignores case (as opposed to -name)
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

        FUZZY_FIND_RESULTS+=("$FUZZY_FIND_RESULT")

        echo "fuzzy-flatpak/fuzzyFind(): Found $FUZZY_FIND_RESULT"
    fi
}

fuzzyPS()
{
    FUZZY_PS_RESULT=""

    # substitue the left-most occurence of \s (any whitespace character)
    # with "" (nothing) and print only second ($0 all, $1 first, $2 second)
    # parameter (which are separated by strings) of result
    # flatpak ps gives results in lines, awk operates per line
    FUZZY_PS_RESULT=$(flatpak ps | awk '{sub(/\s/,"");print $2}')

    if [ -z "$FUZZY_PS_RESULT" ]
    then
        echo "fuzzy-flatpak/fuzzyPS(): No running flatpak processes."

        exit 1
    else
        # todo bug one whitespace character before new line (first result)
        echo -e "fuzzy-flatpak/fuzzyPS(): Found running flatpak processes:\n" \
                "$FUZZY_PS_RESULT"
    fi
}

fuzzyHelp()
{
    # todo bug one whitespace character before every new line
    echo -e "Usage:\n"\
            "  fuzzy-flatpak COMMAND NAME?\n"\
            "\n"\
            "help, -h, --help   Display this help.\n"\
            "info               Needs NAME. Fuzzy-search for NAME and execute"\
                                "\"flatpak info\" with the result.\n"\
            "run                Needs NAME. Fuzzy-search for NAME and execute"\
                                "\"flatpak run\" with the result.\n"\
            "kill               Needs NAME. Fuzzy-search for NAME and execute"\
                                "\"flatpak kill\" with the result.\n"\
            "kill-all           Kill all running flatpak processes."
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

# command is part of fuzzy-flatpak
for i in "${FUZZY_FLATPAK_COMMANDS[@]}"
do
    if [[ $1 == "$i" ]]
    then
        if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]
        then
            fuzzyHelp

            exit 0
        elif [ "$1" == "info" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak info "$FUZZY_FIND_RESULT"

            exit 0
        elif [ "$1" == "run" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak run "$FUZZY_FIND_RESULT"

            exit 0
        elif [ "$1" == "kill" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak kill "$FUZZY_FIND_RESULT"

            exit 0
        elif [ "$1" == "kill-all" ]
        then
            fuzzyPS

            for j in $FUZZY_PS_RESULT
            do
                flatpak kill "$j"
            done

            exit 0
        elif [ "$1" == "update" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"
            flatpak update "$FUZZY_FIND_RESULT"

            exit 0
        fi
    fi
done

# command is not part of fuzzy-flatpak
echo "fuzzy-flatpak: Command \"$1\" not recognized." \
     "Run \"fuzzy-flatpak help\" for help."

exit 1
