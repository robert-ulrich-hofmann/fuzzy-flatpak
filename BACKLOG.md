# backlog

## to readme
- make run and kill accept multiple and start with & to have one console output of a defined bundle
- one find fails, all fails

## backlog
- install script user
- man page

- color with ansi escape codes (maybe close them again)
- but listen to NO_COLOR

- display live preview of fuzzy-find per keystroke in input / like auto complete! :O
- autocomplete fuzzy commands and options :X
- - todo ~/.bash_completion
- getopts

- ffpk?
- "enhanced flatpak cli"

- todo run n what happens if two times the same gets started? worst case check if already running before flatpak run

- todo go from echo to printf and pull strings out of code (how to pass args into strings?)
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

## steps

- clean up first version
- final readme v0.1
- release

- add options
- add command / options detection
- add flatpak commands without name / changes
- add flatpak commands with fuzzy name changes
- add new commands
- v0.2

- add multi name to fuzzy enabled commands
- v0.3

- add setup
- add man?
- add docs
- v1.0

- seal master
- backlog -> issues
- develop
