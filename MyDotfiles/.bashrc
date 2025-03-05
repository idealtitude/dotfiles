# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH

# Does not work...
# if [[ $UID -eq 0 ]]; then
    # export PS1='(\[\e[38;5;154m\]\w\[\e[0m\] \[\e[38;5;208m\]#\[\e[0m\]) \[\e[38;5;121m\]\t\n\[\e[0m\]% '
# else
    # export PS1='(\[\e[38;5;39m\]\W\[\e[0m\] \[\e[38;5;214m\]\$\[\e[0m\]) \[\e[38;5;212m\]\t\[\e[0m\]\n% '
# fi

# export PS1='(\[\e[38;5;39m\]\W\[\e[0m\] \[\e[38;5;214m\]\$\[\e[0m\]) \[\e[38;5;212m\]\t\[\e[0m\]\n% '
# export PS1='╭(\[\e[38;5;39m\]\w\[\e[0m\] [\[\e[38;5;226m\]\$\[\e[0m\]]) ─ \[\e[38;5;247m\]\t\n\[\e[0m\]╰> '
export PS1='╭(\[\e[38;5;39m\]\w\[\e[0m\] \[\e[38;5;247m\][\[\e[38;5;226m\]\$\[\e[38;5;247m\]]\[\e[0m\]) \[\e[38;5;247m\]\t\n\[\e[0m\]╰> '

# My personnal logs path
export MYLOGS='/home/stephane/Utils/logs'

# HISTORY
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=2000
export HISTFILESIZE=2000
shopt -s histappend

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
 ²           . "$rc"
        fi
    done
fi
unset rc

### zoxide + eza + fzf config
# eval "$(zoxide init bash)"
eval "$(zoxide init bash --cmd z)"

# export FZF_DEFAULT_OPTS="
# Define _ZO_FZF_OPTS as an array
_ZO_FZF_OPTS=(
  --height 40%
  --reverse
  --border
  --preview 'eza --tree --color=always --level=2 {} 2>/dev/null'
)

function zoxide_fzf() {
  local selected
  selected=$(zoxide query --list | fzf "${_ZO_FZF_OPTS[@]}") && cd "$selected"
}

# Alt+Z to launch zoxide + fzf
bind '"\ez":"zoxide_fzf\n"'
