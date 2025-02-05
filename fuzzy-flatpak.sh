#!/bin/bash -

# fuzzy-flatpak: Make some flatpak commands accept fuzzy names

FUZZY_FLATPAK_COMMANDS=("help" "-h" "--help"
                        "info"
                        "run"
                        "kill"
                        "kill-all"
                        "update"
)

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
    FUZZY_FIND_RESULTS=()

    for i in "${@:1}"
    do
        FUZZY_FIND_RESULT=""

        # -maxdepth 1 just on given level, don't go deeper (lot's of duplicates)
        # -type d = directory
        # -iname ignores case (as opposed to -name)
        # -print -quit prints just first result and then ends find
        FUZZY_FIND_RESULT=$(find "$HOME/.var/app" -maxdepth 1    \
                                                  -type d        \
                                                  -iname "*$i*"  \
                                                  -print         \
                                                  -quit          \
        )

        if [ -z "$FUZZY_FIND_RESULT" ]
        then
            echo "fuzzy-flatpak/fuzzyFind(): Can not find application \"$i\"."

            exit 1
        else
            # remove from string anything before and including exactly
            # ".var/app/""
            FUZZY_FIND_RESULT=${FUZZY_FIND_RESULT##*.var/app/}

            # add result to array of results
            FUZZY_FIND_RESULTS+=("$FUZZY_FIND_RESULT")

            echo "fuzzy-flatpak/fuzzyFind(): \"$i\" matches $FUZZY_FIND_RESULT"
        fi
    done
}

fuzzyPS()
{
    FUZZY_PS_RESULTS=()

    # shellcheck disable=SC2207
    # array=split(output of awk at whitespaces)
    FUZZY_PS_RESULTS=($(flatpak ps | awk '{for (i=3; i<=NF; i+=4) print $i}'))

    # shellcheck disable=SC2207
    # remove duplicates
    FUZZY_PS_RESULTS=($(for i in "${FUZZY_PS_RESULTS[@]}"; do echo "$i"; done | sort -u))

    # "${array[*]}" concatenates all elements to one string
    if [ -z "${FUZZY_PS_RESULTS[*]}" ]
    then
        echo "fuzzy-flatpak/fuzzyPS(): No running flatpak processes."

        exit 1
    fi
}

fuzzyHelp()
{
    # todo bug one whitespace character before every new line
    # todo update no kill-all, kill / -all, update
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

            flatpak info "${FUZZY_FIND_RESULTS[0]}"

            exit 0
        elif [ "$1" == "run" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "${@:2}"

            for j in "${FUZZY_FIND_RESULTS[@]}"
            do
                flatpak run "$j" &
            done

            exit 0
        elif [ "$1" == "kill" ]
        then
            # kill -a / kill -all
            if [ "$2" == "-a" ] || [ "$2" == "--all" ]
            then
                fuzzyPS

                for j in "${FUZZY_PS_RESULTS[@]}"
                do
                    flatpak kill "$j"
                done

                exit 0
            fi

            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"

            flatpak kill "${FUZZY_FIND_RESULTS[0]}"

            exit 0
        elif [ "$1" == "update" ]
        then
            # pass the script's arguments starting with "$2"
            checkIfNameProvided "${@:2}"
            fuzzyFind "$2"

            # todo: update 1 or update 1..n ?
            flatpak update "${FUZZY_FIND_RESULTS[0]}"

            exit 0
        fi
    fi
done

# command is not part of fuzzy-flatpak
echo "fuzzy-flatpak: Command \"$1\" not recognized." \
     "Run \"fuzzy-flatpak help\" for help."

exit 1
