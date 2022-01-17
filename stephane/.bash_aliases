# Personnel UpdateDB
alias pudb="updatedb -l 0 -o /home/stephane/.hlocate/hlocate.db -U /home/stephane"

# Personnel Locate
alias ploc="locate -d /home/stephane/.hlocate/hlocate.db"

# Clear screen
# alias cls="tput clear"

# Clear screen (short version)
alias c="clear"

# exa commande
alias l="exa"
alias lx="exa -l"
alias la="exa -a"
alias lxa="exa -la"

# diff with colors
alias diff="diff --color=always"

# stat shortcuts
alias stata='stat -c "%a"'
alias stataa='stat -c "%A %a %n"'
alias stataz='stat -c "%a %C"'

# Date now YYYY-MM-DD HH:MM:SS
alias dnow='date +"%Y-%m-%d %H:%M:%S"'

# Play medias
alias play="ffplay -nodisp -autoexit"
alias dplay="ffplay -hide_banner --showmode 2 -autoexit"

# Copy/Paste
alias cpy=pcopy
pcopy() {
	$* | xsel -b -i
}

#ppaste() {
#	xsel -b -o
#}

# Git session cache
alias gitcache="git config --global credential.helper 'cache --timeout=3600'"

# ed setup
alias edp='ed -p"% "'

# Python 3.10 interactive interpreter
alias py310="python3.10"

# Quick python server
alias pyserv="python -m http.server 8000"

# Jupyter Notebook
alias jupynb='jupyter notebook'
# Jupyter Lab
alias jupylab='jupyter lab'

# Get my IP
# alias myip="host myip.opendns.com resolver1.opendns.com"
