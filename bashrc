# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# --- Secrets (gitignored, per-machine) ---
[ -f "$HOME/.config/bash/.env" ] && . "$HOME/.config/bash/.env"

# --- History ---
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# --- Shell options ---
set -o vi
stty -ixon
shopt -s checkwinsize
#shopt -s globstar

# --- Prompt ---
PS1='\[\e[1;37m\][\u@\W]\$\[\e[0m\] '

case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
  ;;
esac

export PS1

# --- Colors ---
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

export COLORTERM=truecolor

# --- Aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if command -v nvim &>/dev/null; then
  alias vim="nvim"
  alias vi="nvim"
  export EDITOR="nvim"
else
  export EDITOR="vi"
fi

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# --- Completion ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- nvm (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -d "$HOME/npm/bin" ] && export PATH="$HOME/npm/bin:$PATH"

# --- conda ---
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
  elif [ -d "$HOME/anaconda3" ]; then
    export PATH="$HOME/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup

# --- Deno ---
if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# --- CUDA ---
[ -d /usr/local/cuda ] && export PATH="/usr/local/cuda/bin:$PATH"

# --- Rust/Cargo ---
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --- Haskell (ghcup) ---
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# --- asdf ---
[ -f "$HOME/.asdf/asdf.sh" ] && . "$HOME/.asdf/asdf.sh"
[ -f "$HOME/.asdf/completions/asdf.bash" ] && . "$HOME/.asdf/completions/asdf.bash"

# --- Angular CLI completion (disabled — no longer used) ---
# command -v ng &>/dev/null && source <(ng completion script)

# --- Misc ---
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1

# --- Machine-specific overrides (gitignored) ---
# Copy bashrc.local.example to bashrc.local and fill in paths for this machine.
[ -f "$HOME/.config/bash/bashrc.local" ] && . "$HOME/.config/bash/bashrc.local"
