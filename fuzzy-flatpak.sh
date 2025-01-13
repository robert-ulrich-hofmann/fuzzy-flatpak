
#!bin/bash -

# flatpak fuzzy finder for easier flatpak run

# fuzzy-flatpak
# guards against multiple arguments
# guard against flatpak not found
# echo info output after every step and function call?
# echo fails (too many input, no input)

# readme
# readme only dependency flatpak
# readme option to run it detached or in this terminal with &
# if yes give readme: block this terminal or run detached, but still with A LOT of output
# give instructions how to "install it locally for user / root / all"
# also give instruction how to (partially) override flatpak with alias?
# get to know find command and options, explain in readme?


if !flatpak
echo dependency
exit

if !$1
no command
exit

if $3
too many arguments
exit

# todo optional step verify and enter / abort before actual commands?
#if allowed command
#    if help
#    help
#    exit

#    if debug
#    debug / no last found
#    exit

#    if !$2
#    no name
#    exit

#    if info
#    fuzzy-find($2)
#    info
#    exit

#    if run
#    fuzzy-find($2)
#    run
#    no exit (?)

#    if kill
#    fuzzy-ps($2)
#    kill
#    exit
#else
#no allowed command
#exit


# todo this in function fuzzy-find()
# todo error not found and exit (always return result or exit)
# -maxdepth 1 just on given level, don't go deeper (lot's of duplicates here)
# -type d = directory
# -iname ignores case as opposed to -name
# -print -quit just prints first result and ends find
TEST1=$(find "$HOME/.var/app" -maxdepth 1 -type d -iname "*bottLeS*" -print -quit)
echo ${TEST1##*.var/app/}

# TODO fuzzy-ps()
# todo nothing running
# todo error not found and exit (always return result or exit)

# TODO debug last used (not found, actually used?) argument by printing this variable?

# verification step here if the substring is rly in .var/app/ ?

# output echo what would be started and option user input to yes enter start / return / abort?
# todo pretty output with info / parts of info?

# remove from string anything-before-and-including-exactly(.var/app/)
flatpak run ${TEST1##*.var/app/}
