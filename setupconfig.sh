#!/bin/bash

# What does this do?
#    The main purpose of this script is to make the bash terminal and 
#    vim look better and have custom common aliases
#    This script will copy its contents into 4 files, .profile, .bashrc, .vimrc, and .inputrc

# How to use this script:
#    Copy the contents into a new file -> vim setupconfig.sh
#    Allow exicution -> chmod 744 setupconfig.sh
#    Run Script -> ./setupconfig.sh

# Define the contents of each file
read -r -d '' PROFILE_CONTENT <<'EOF'
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

##### Load in /etc/profile.d configurations for root
if (( $UID == 0 )); then
  for i in /etc/profile.d/*.sh /etc/profile.d/sh.local ; do
    if [ -r "$i" ] && ! [[ $i == *"pwage.sh" ]]; then
      if [ "${-#*i}" != "$-" ]; then
        . "$i"
      else
        . "$i" > /dev/null
      fi
    fi
  done
fi
EOF



read -r -d '' BASHRC_CONTENT <<'EOF'
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##### User specific aliases

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias lt='ls -ltr --color=auto --group-directories-first'
alias la='LC_COLLATE=C ls -alF --group-directories-first'
alias ll='ls -lah --color=auto --group-directories-first'
alias lwd='ls -ld1 --color=auto --group-directories-first "$PWD"/*'
alias ver='cat /etc/*-release'
alias whoson='last -w|tac'
alias myip='hostname -i'
alias masterlist='vim /byu/scripts/ansible/daily_Audit/masterlist.txt'
alias profile='vim $HOME/.profile'
alias home='cd $HOME'
alias details=get_machine_info
alias sssdcache='systemctl stop sssd && rm -rf /var/lib/sss/db/* && systemctl start sssd'
alias c='clear'
alias src='source $HOME/.profile'
alias vim='vim -u $HOME/.vimrc'

##### Set correct TERM variable. Allows vim to use alternate screen and correct color scheme
export TERM=xterm-256color

export INPUTRC="$HOME/.inputrc"

HISTTIMEFORMAT="%d/%m/%y %T "
bind 'set bell-style none'

##### Modified mkdir command that cds into the new directory
function mmkdir() {
  command mkdir -p $1; cd $1
}

##### Function to get the info for the Ubuntu or Red Hat machine currently being used
function get_machine_info() {
  if [ `cat /etc/*-release | grep "ubuntu" | wc -w` == "0" ]; then
    if [ `cat /etc/*-release | grep "6.10" | wc -w` -ne "0" ]; then
      os="rh6.10"
    else
      os="rh"
    fi
  else
    os="ubu"
  fi

  ver="$os`cat /etc/*-release | grep "VERSION_ID" | grep -o -P '(?<=\").*(?=\")'`"
  name=`hostname`
  ip=`hostname -i`

  printf "******************************\n"
  echo Hostname: $name
  echo IP address: $ip
  echo Operating system: $ver
  printf "******************************\n"
}

##### Function to show the hostgroup of the current host
function hostgroup() {
  if ! [[ -z $1 ]]; then
    name=$1
  else
    name=$HOSTNAME
  fi
  kinit adm.tychart@ENTRALO-PROD.BYU.EDU && ipa host-show $name | grep host-groups: | sed 's/.*://' | xargs -n 1
}

##### Improved root login preserves bash profile
function ssu() {
        #sudo -H HOME=$HOME bash --rcfile $HOME/.profile -i
        sudo -H HOME=$HOME bash -i
}

shopt -s checkwinsize

##### Sets specific command prompts for user vs root
if [ "$TERM" == "xterm-color" ]; then
  export PS1="\u@\h \w $"
else
  if (( $UID != 0 )); then
    export PS1="\[\e[1;32m\]\u\[\e[0m\]@\[\e[0;31m\]\h\[\e[1;36m\](`get_machine_info | grep "Operating system" | cut -d " " -f 3`) \[\e[1;34m\]\w \[\e[0m\]$ \[\e[0m\]"
  else
    export PS1="\[\e[1;35m\]\u\[\e[0m\]@\[\e[0:31m\]\h\[\e[1;36m\](`get_machine_info | grep "Operating system" | cut -d " " -f 3`) \[\e[01;34m\]\w\[\e[0m\] # "
  fi
fi

export PATH=$PATH:~/.local/bin
export EDITOR=vim

EOF



read -r -d '' VIMRC_CONTENT <<'EOF'
syntax on

set tabstop=2
set shiftwidth=2
set autoindent
set nocp
set number
set expandtab
set showcmd
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set backspace=indent,eol,start
set ruler
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
set noerrorbells
set vb t_vb=
set cursorline
map <F6> :call ToggleCurline()<CR>
imap <F6> :call ToggleCurline()<CR>

set mouse=a
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>

map <ScrollWheelUp> <Up>
map <ScrollWheelDown> <Down>

"nnoremap <space> :nohlsearch<CR>
"imap <A-left> <S-left>
"imap <Esc><BS> <C-W>

fu! ToggleCurline ()
  if &cursorline
    set nocursorline
  else
    set cursorline
  endif
endfunction

augroup vimStartup
  au!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END
EOF



read -r -d '' INPUTRC_CONTENT <<'EOF'
# /etc/inputrc - global inputrc for libreadline
# See readline(3readline) and `info rluserman' for more information.

# Be 8 bit clean.
set input-meta on
set output-meta on

# To allow the use of 8bit-characters like the german umlauts, uncomment
# the line below. However this makes the meta key not work as a meta key,
# which is annoying to those which don't need to type in 8-bit characters.

# set convert-meta off

# try to enable the application keypad when it is called.  Some systems
# need this to enable the arrow keys.
# set enable-keypad on

# see /usr/share/doc/bash/inputrc.arrows for other codes of arrow keys

# do not bell on tab-completion
# set bell-style none
# set bell-style visible

# some defaults / modifications for the emacs mode
$if mode=emacs

# allow the use of the Home/End keys
"\e[1~": beginning-of-line
"\e[4~": end-of-line

# allow the use of the Delete/Insert keys
"\e[3~": delete-char
"\e[2~": quoted-insert

# mappings for "page up" and "page down" to step to the beginning/end
# of the history
# "\e[5~": beginning-of-history
# "\e[6~": end-of-history

# alternate mappings for "page up" and "page down" to search the history
# "\e[5~": history-search-backward
# "\e[6~": history-search-forward

# mappings for Ctrl-left-arrow and Ctrl-right-arrow for word moving
"\e[1;5C": forward-word
"\e[1;5D": backward-word
"\e[5C": forward-word
"\e[5D": backward-word
"\e\e[C": forward-word
"\e\e[D": backward-word

# mapping to Ctrl-backspace delete words
"\C-H": shell-backward-kill-word

$if term=rxvt
"\e[7~": beginning-of-line
"\e[8~": end-of-line
"\eOc": forward-word
"\eOd": backward-word

$endif

# for non RH/Debian xterm, can't hurt for RH/Debian xterm
# "\eOH": beginning-of-line
# "\eOF": end-of-line

# for freebsd console
# "\e[H": beginning-of-line
# "\e[F": end-of-line

$endif
EOF



# Define the paths for each file
profile_file="$HOME/.profile"
bashrc_file="$HOME/.bashrc"
vimrc_file="$HOME/.vimrc"
inputrc_file="$HOME/.inputrc"

# Copy the contents to the respective files and capture errors
echo "$PROFILE_CONTENT" > "$profile_file" 2> /tmp/profile_error
echo "$BASHRC_CONTENT" > "$bashrc_file" 2> /tmp/bashrc_error
echo "$VIMRC_CONTENT" > "$vimrc_file" 2> /tmp/vimrc_error
echo "$INPUTRC_CONTENT" > "$inputrc_file" 2> /tmp/inputrc_error

# Check if any error file is not empty
if [[ -s /tmp/profile_error || -s /tmp/bashrc_error || -s /tmp/vimrc_error || -s /tmp/inputrc_error ]]; then
    # Output failure message
    echo "Error: Files not copied successfully!"
    # Print error messages
    echo "Profile error:"
    cat /tmp/profile_error
    echo "Bashrc error:"
    cat /tmp/bashrc_error
    echo "Vimrc error:"
    cat /tmp/vimrc_error
    echo "Inputrc error:"
    cat /tmp/inputrc_error

    # Clean up temporary error files
    rm -f /tmp/profile_error /tmp/bashrc_error /tmp/vimrc_error /tmp/inputrc_error

else
    # Output success message
    echo "Files copied successfully!"
    
    # Script executed successfully, remove the script file
    echo "Removing this setup script"
    rm "$0"
fi
