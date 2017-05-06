# undef console output stop (enable bash's incremental search)
stty stop undef

# functions
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

# command alias
alias ls="ls -GF"
alias la="ls -GFa"
alias ll="ls -GFl"
alias lla="ls -GFal"
alias tmux-changekey='tmux set-option -ag prefix C-b'
alias tmux-revertkey='tmux set-option -ag prefix C-t'

# locale
export LC_ALL=en_US.UTF-8

# git utilities
source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

# prompt
export PS1='\[\e[36m\]\u@\h:\[\e[35m\]\W\[\e[1;32m\]$(__git_ps1 " (%s)")\[\e[36m\] \$\[\e[0m\] '

# editor for osx
MACVIM_PATH="/Applications/MacVim.app"
if is_osx and [ -f "$MACVIM_PATH" ]; then
  export EDITOR="$MACVIM_PATH/Contents/MacOS/Vim"
  alias vi='env LANG=ja_JP.UTF-8 '"$MACVIM_PATH"'/Contents/MacOS/Vim "$@"'
  alias vim='env LANG=ja_JP.UTF-8 '"$MACVIM_PATH"'/Contents/MacOS/Vim "$@"'
fi

# ctags
alias ctags=`brew --prefix`/bin/ctags

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# local bin path
export PATH=$PATH:~/bin


# tmux auto start
# http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1

    if is_tmux_runnning; then
      printf "\e[31;1m  _____ __  __ _   ___  __ \e[m\n"
      printf "\e[31;1m |_   _|  \/  | | | \ \/ / \e[m\n"
      printf "\e[31;1m   | | | |\/| | | | |\  /  \e[m\n"
      printf "\e[31;1m   | | | |  | | |_| |/  \  \e[m\n"
      printf "\e[31;1m   |_| |_|  |_|\___//_/\_\ \e[m\n"
    elif is_screen_running; then
      echo "This is on screen."
    fi
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi

      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '\[\d*x\d*\]'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
          tmux attach-session
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
          tmux attach -t "$REPLY"
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        fi
      fi

      echo -n "Tmux: create new session? (y/N) "
      read
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        if is_osx && is_exists 'reattach-to-user-namespace'; then
          # on OS X force tmux's default command
          # to spawn a shell in the user's namespace
          tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
          tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
        else
          tmux new-session && echo "tmux created new session"
        fi
      fi
    fi
  fi
}
tmux_automatically_attach_session

# vi mode
set -o vi

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--reverse --border --height 50%'
