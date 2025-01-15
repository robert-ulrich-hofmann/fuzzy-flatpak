#!/bin/bash -

# Make some flatpak commands accept fuzzy names

fuzzyFlatpakCommands=("help" "info" "run" "kill")

fuzzyFind()
{
    FUZZY_FIND_RESULT=""

    # -maxdepth 1 just on given level, don't go deeper (lot's of duplicates here)
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
        echo "fuzzy-flatpak/fuzzy-find(): Can not find this application"
        exit 1
    else
        # remove from string anything-before-and-including-exactly(.var/app/)
        echo "$FUZZY_FIND_RESULT"
        FUZZY_FIND_RESULT=${FUZZY_FIND_RESULT##*.var/app/}
        echo "fuzzy-flatpak/fuzzy-find(): Found $FUZZY_FIND_RESULT"
    fi
}

checkApplicationRunning()
{
    echo "checkApplicationRunning"
    # compare flatpak ps and $1
    # return true 1 / false 0
}

getRunningProcesses()
{
    echo "getRunningProcesses"
    # get all running processes as names
    # return array
}

fuzzyRun()
{
    echo "fuzzyRun"
}

# TODO fuzzy-ps(): get name with fuzzy-find and look up in ps
# todo nothing running
# todo error not found and exit (always return result or exit)

# todo interactive like rm -i
# output echo what would be started and option user input to yes enter start / return / abort?
# TODO instead of this display live preview per keystroke in input! :O

# todo kill all but []?

#if !flatpak
#echo dependency
#exit
if [[ ! $(command -v flatpak) ]]
then
    echo "Something dependency here TODO"
    exit 1
fi

#if !$1
#no command
#exit 1
if [ ! "$1" ]
then
    echo "Something command here TODO"
    exit 1
fi

#if allowed command
for i in "${fuzzyFlatpakCommands[@]}"
do
    if [[ $1 == "$i" ]]
    then
        if [ "$1" == "help" ]
        then
            echo "help"
            exit 0
        elif [ "$1" == "info" ]
        then
            #    if !$2
            #    no name
            #    exit 1
            echo "info"
            exit 0
        elif [ "$1" == "run" ]
        then
            #    if !$2
            #    no name
            #    exit 1
            # todo fuzzyRun $2
            echo "run"
            # todo if ! $2 guard exit 1
            fuzzyFind "$2"
            flatpak run "$FUZZY_FIND_RESULT" & # todo test this outside
            exit 0
        elif [ "$1" == "kill" ]
        #    if kill
        #       if all
        #       ps
        #       kill[]
        #    else
        #    fuzzy-ps($2)
        #    kill (if all: single kill & calls)
        #    exit 0
        then
            # if !#2 kill all
            # else   kill X
            echo "kill"
            exit 0
        fi
    fi
done

echo "Command not recognized"
exit 1
