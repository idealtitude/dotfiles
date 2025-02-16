# Personnel UpdateDB
#alias plocu="updatedb -l 0 -o /home/stephane/.hlocate/hlocate.db -U /home/stephane"

# Personnel Locate
#alias ploc="locate -d /home/stephane/.hlocate/hlocate.db"

# Clear screen (short version)
alias c="clear"

# exa commande
alias l="eza -g --group-directories-first"
alias ll="eza -lg --group-directories-first"
alias la="eza -ag --group-directories-first"
alias lla="eza -lag --group-directories-first"

# number of elements in directory
# alias lc='python -c "from os import listdir, getcwd; print(len(listdir(getcwd())))"'
alias lc='eza -l | wc -l'
alias lca='eza -la | wc -l'

# diff with colors
alias diff="diff --color=always"

# stat shortcuts
alias stata='stat -c "%a"'
alias stataa='stat -c "%A %a %n"'
alias stataz='stat -c "%a %C"'

# micro
alias mi="micro"

# bpython
alias bp="bpython"

# Random wallpapers
alias chwp='feh --recursive --bg-max --randomize ~/Images/WALLPAPERS_00/'

# Change wallpapers
alias r='cw'

# jobs
alias j='jobs -l'

# ps
alias p='ps -fp'

# history tail
alias h='history | tail -n 10'

# appinfos
alias ai='appinfos'

# Date now YYYY-MM-DD HH:MM:SS
alias dnow='date +"%Y-%m-%d %H:%M:%S"'

# Put cwd in clipboard
alias gcwd='printf "%s" "$(pwd)" | xsel -b -i'

# Ranger, cd on exit (requires file “~/.rangerdir”)
alias rr='ranger'
alias rrr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Check shell, subshells (doesn't work!)
# alias shsubsh='[[ "$$" -eq "$BASHPID" ]] && printf "%s\n" "Shell, not subshell" || printf "%s\n" "Subshell, not shell"'

# Play medias
alias play="ffplay -nodisp -autoexit"
alias dplay="ffplay -hide_banner --showmode 2 -autoexit"

# Git session cache
#alias gitcache="git config --global credential.helper 'cache --timeout=3600'"

# ed setup
alias edp='ed -p"% "'

# Quick python server
#alias pyserv="python -m http.server 8000"
