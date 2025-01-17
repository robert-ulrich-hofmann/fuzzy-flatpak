# WIP: fuzzy-flatpak

## Description

This application enables the user to use certain flatpak commands without
searching for / knowing / having to use the typical three-part identifier.
Instead fuzzy-flatpak will "fuzzy search" for this identifier based on the
given name.

## Installation

<!-- TODO  -->
For now: Manual.

Upcomming: Installer!

## Usage

reasoning
feedback / contributions welcome?
readme only dependency flatpak and bash and also standard setup (location of flatpak $HOME/.var/app/)
have not tested how supersets of bash (e.g. zsh) behave with it
how to use: call this sh (maybe chmod) or copy this file into ...
give instructions how to "install it locally for user / root / all"
also give instruction how to (partially) override flatpak with alias?
get to know find command and options, explain in readme?
worst case write entire name always find. if results wrong write more
chars and get more precise
option to "run &" is preserverd and works as expected / like in plain flatpak
check all exit codes again
todo fuzzyFlatpak better?
evaluate: print / printf instead of echo? why?

## TODO backlog

- make run and kill accept multiple programs? (run will create insane
output) also: if multiple input fail all on one or per case?
- reverse kill: kill all but [these]
- kill n [these]
- install script user
- man page
- display live preview per keystroke in input / like auto complete! :O
- interactive like rm -i for run and kill with user input y/n (hard to do
with multiple names) output what was found and wait for descision.
- if you add more features rename from fuzzy to enhance?
- or finish the fuzzy part in fuzzy-flatpak and redo it with more features in
another project?
- color with ansi escape codes (maybe close them again)

todo kill n fuzzyFind can't exit anymore, have to exit if !FUZZYRESULT
thats why we clear it on every call

todo run n what happens if two times the same gets started? worst case check if already running before flatpak run

todo ~/.bash_completion

todo go from echo to printf and pull strings out of code (how to pass args into strings?)

## TODO license cc0 multi-public-domain beerware

todo add usage/help as comment and header and do <https://stackoverflow.com/questions/430078/shell-script-templates>
todo header name license revision version
todo make version command?

todo encapsulate program in main() ? problems with args?

todo "release" this on reddit/linux-gaming or sth like that? :x

next step
release v1 with good readme

next versions:
develop whole features and clean master merge commits:
    refactor fuzzy-find to not exit anymore and everwhere else exit
    refactor run to run n
    refactor kill to kill n
    refactor main into function
    refactor all echo to printf (why?)
    refactor all strings outside of code and pass arguments into them
    add install.sh (always add nice and clean with comment to users configs!)
        install without .sh but keep developing in .sh
        chmod 744
        add bash-completion to install.sh
        add man page to install.sh
    add options pass through (to flatpak)
    add directory option to search in other location
    add -i interactive mode
    add detached mode (always &)
    maybe all this in a .config?
