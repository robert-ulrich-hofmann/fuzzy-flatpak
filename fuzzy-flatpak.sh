#!bin/bash -

# flatpak fuzzy finder for easier flatpak run

# fuzzy-flatpak
# guards against multiple arguments
# guard against flatpak not found
# echo info output after every step and function call?
# echo fails (too many input, no input)
# finally add kill all feature

# readme
# description
# reasoning
# feedback / contributions welcome?
# readme only dependency flatpak
# readme option to run it detached or in this terminal with & (tested, it works as expected)
# if yes give readme: block this terminal or run detached, but still with A LOT of output
# how to use: call this sh (maybe chmod) or copy this file into ...
# give instructions how to "install it locally for user / root / all"
# also give instruction how to (partially) override flatpak with alias?
# get to know find command and options, explain in readme?

LAST_FINDING=""
fuzzyFlatpakCommands=("help" "info" "run" "kill")

# TODO guard this against no input outside
# TODO stateless, handle LAST_FINDING only outside if you want debug
# TODO always return result or exit
fuzzyFind()
{
    RESULT="" # todo debug scope of this, is this outside after execution?

    # -maxdepth 1 just on given level, don't go deeper (lot's of duplicates here)
    # -type d = directory
    # -iname ignores case as opposed to -name
    # -print -quit just prints first result and ends find
    RESULT=$(find "$HOME/.var/app" -maxdepth 1    \
                                   -type d        \
                                   -iname "*$1*"  \
                                   -print         \
                                   -quit          \
    )

    if [ -z $RESULT ]
    then
        echo "fuzzy-flatpak/fuzzy-find(): Can not find this application"
    else
        # remove from string anything-before-and-including-exactly(.var/app/)
        RESULT=${RESULT##*.var/app/}
        echo "fuzzy-flatpak/fuzzy-find(): Found $RESULT"
    fi

    return $RESULT #TODO empty?
}

checkApplicationRunning()
{
    echo "check"
    # compare flatpak ps and $1
    # return true / false
}

getRunningProcesses()
{
    echo "get"
    # get all running processes as names
    # return array
}

# TODO fuzzy-ps(): get name with fuzzy-find and look up in ps
# todo nothing running
# todo error not found and exit (always return result or exit)

# TODO debug last used (not found, actually used?) argument by printing this variable?

# todo interactive like rm -i
# output echo what would be started and option user input to yes enter start / return / abort?
# TODO instead of this display live preview per keystroke in input! :O

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
if [ ! $1 ]
then
    echo "Something command here TODO"
    exit 1
fi

#if allowed command
for i in "${fuzzyFlatpakCommands[@]}"
do
    if [[ $1 == $i ]]
    then
        if [ $1 == "help" ]
        then
            echo "help"
        elif [ $1 == "info" ]
        then
            echo "info"
        elif [ $1 == "run" ]
        then
            echo "run"
        elif [ $1 == "kill" ]
        then
            echo "kill"
        fi
    fi
done

# todo this can only be here if we can exit 0 in run
echo "Command not recognized"
exit 1

#    if help
#    help
#    exit 0

#    if debug
#    debug / no last found (first run, no successfull run yet)
#    exit 0

#    if !$2
#    no name
#    exit 1

#    if info
#    fuzzy-find($2)
#    info
#    exit 0

#    if run
#    fuzzy-find($2)
#    run
#    no exit (?)

#    if kill
#       if all
#       ps
#       kill[]
#    else
#    fuzzy-ps($2)
#    kill (if all: single kill calls)
#    exit 0
#else
#no allowed command
#exit 1
