# backlog

- make run and kill accept multiple and start with & to have one console output of a defined bundle
- add update to fuzzy commands (can also accept one program)
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

- autocomplete fuzzy names and commands and options :X
- get autocomplete on commands from flatpak or do your own?
- do autocomplete on names
- get autocomplete on options from flatpak or do your own?

- full flatpak replacement and installer with alias, optional with --set-alias user defined?
- ffpk?
- "enhanced flatpak cli"
- allow multiple names, parse until "-" (options) or end and assume all as names after first (command)
- pass all original to flatpak
- describe enhancements
- describe new commands

- todo kill n fuzzyFind can't exit anymore, have to exit if !FUZZYRESULT
- thats why we clear it on every call

- todo run n what happens if two times the same gets started? worst case check if already running before flatpak run
- todo ~/.bash_completion
- todo go from echo to printf and pull strings out of code (how to pass args into strings?)

- check all exit codes again
- evaluate: print / printf instead of echo? why?

## license cc0 multi-public-domain beerware

- todo add usage/help as comment and header and do <https://stackoverflow.com/questions/430078/shell-script-templates>
- todo header name license revision version
- todo make version command?
- todo encapsulate program in main() ? problems with args?
- todo "release" this on reddit/linux-gaming or sth like that? :x
- next step
- release v1 with good readme
- develop whole features and clean master merge commits:
-     refactor fuzzy-find to not exit anymore and everwhere else exit
-     refactor run to run n
-     refactor kill to kill n
-     refactor main into function
-     refactor all echo to printf (why?)
-     refactor all strings outside of code and pass arguments into them
-     add install.sh (always add nice and clean with comment to users configs!)
-         install without .sh but keep developing in .sh
-         chmod 744
-         add bash-completion to install.sh
-         add man page to install.sh
-     add options pass through (to flatpak)
-     add directory option to search in other location
-     add -i interactive mode
-     add detached mode (always &)
-     maybe all this in a .config?
