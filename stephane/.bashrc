# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export PATH="$HOME/.npm/bin:$PATH"

# Prompt:
# export PS1="\[\033[38;5;87m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;227m\]\\$\[$(tput sgr0)\]: \[$(tput sgr0)\]"

export PS1="(\[$(tput sgr0)\]\[\033[38;5;75m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;221m\]\\$\[$(tput sgr0)\]) \[$(tput sgr0)\]\[\033[38;5;225m\]\t\[$(tput sgr0)\]\n% \[$(tput sgr0)\]"

# HISTORY
# export HISTTIMEFORMAT ← A définir!
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=2000
export HISTFILESIZE=2000
shopt -s histappend

# TMUX NNN MICRO
export VISUAL=tmnnmic

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
#[ -f /home/stephane/Dev/JS/TEST/elecforge/node_modules/tabtab/.completions/electron-forge.bash ] && . /home/stephane/Dev/JS/TEST/elecforge/node_modules/tabtab/.completions/electron-forge.bashsource "$HOME/.cargo/env"
