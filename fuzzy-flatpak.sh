# flatpak fuzzy finder for easier flatpak run
# give own name flatpak-run?
# guards against multiple arguments
# guard against flatpak not found (readme only dependency flatpak)
# echo some info output
# echo fails (too many input, no input)
# get to know find command and options, explain in readme?
# option to run it detached or in this? (&)
# TODO test: can you just run flatpak-run X & ???
# if yes give readme: block this terminal or run detached, but still with A LOT of output
# give instructions how to "install it locally for user / root / all"
# also give option to override with alias?
# make local variable or delete it after use
# pipe it into flatpak run

# -maxdepth 1 just on given level, don't go deeper (lot's of duplicates here)
# -type d = directory
# -iname ignores case instead of -name
# -print -quit just prints first result and ends find
TEST1=$(find "$HOME/.var/app" -maxdepth 1 -type d -iname "*steam*" -print -quit)
echo ${TEST1##*.var/app/}

# TODO debug last used (not found, actually used?) argument by printing this variable?

# verification step here if the substring is rly in .var/app/ ?

# output echo what would be started and option user input to yes enter start / return / abort?
# todo pretty output with info / parts of info?

# remove from string anything-before-and-including-exactly(.var/app/)
flatpak run ${TEST1##*.var/app/}




# do this as fuzzy-flatpak and enahnce run AND kill (search in flatpak ps) AND info AND ?
# command $1 argument $2
# info
# run
# kill
# help
# "debug"
