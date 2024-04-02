#!/bin/bash

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

tycharthome="/home/tychart"


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
alias profile='vim $tycharthome/.profile'
alias scripts='cd /byu/scripts/tychart'
alias home='cd $tycahrthome'
alias details=get_machine_info
alias sssdcache='systemctl stop sssd && rm -rf /var/lib/sss/db/* && systemctl start sssd'
alias c='clear'
alias src='source $tycharthome/.profile'
alias vim='vim -u $tycharthome/.vimrc'
alias mtail='multitail -cS ansible'

##### Set correct TERM varia#!/bin/bash

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
ble. Allows vim to use alternate screen and correct color scheme
export TERM=xterm-256color

export INPUTRC="$tycharthome/.inputrc"

HISTTIMEFORMAT="%d/%m/%y %T "
bind 'set bell-style none'#!/bin/bash

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

tycharthome="/home/tychart"


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
alias profile='vim $tycharthome/.profile'
alias scripts='cd /byu/scripts/tychart'
alias home='cd $tycahrthome'
alias details=get_machine_info
alias sssdcache='systemctl stop sssd && rm -rf /var/lib/sss/db/* && systemctl start sssd'
alias c='clear'
alias src='source $tycharthome/.profile'
alias vim='vim -u $tycharthome/.vimrc'
alias mtail='multitail -cS ansible'

##### Set correct TERM variable. Allows vim to use alternate screen and correct color scheme
export TERM=xterm-256color

export INPUTRC="$tycharthome/.inputrc"

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
        sudo -H bash -rcfile $tycharthome/.profile
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

##### Trying to do autocomplete for typing in server names
# Currently doesn't work
#complete -W "$(echo` cat "$tycharthome/.ssh/known_hosts" |cut -f 1 -d ' ' |  tr , '\n' | cut -f 2 -d '[' | cut -f 1 -d ']' | sort | uniq`;)" ssh
EOF

read -r -d '' VIMRC_CONTENT <<'EOF'
syntax on

set autoindent expandtab tabstop=2 shiftwidth=2

set nocp
set tabstop=2
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

# Copy the contents to the respective files
echo "$PROFILE_CONTENT" > "$profile_file"
echo "$BASHRC_CONTENT" > "$bashrc_file"
echo "$VIMRC_CONTENT" > "$vimrc_file"
echo "$INPUTRC_CONTENT" > "$inputrc_file"

# Output success message
echo "Files copied successfully!"


