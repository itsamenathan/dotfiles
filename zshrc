[ -d ~/.myzsh ] || git clone -b dev https://github.com/myzsh/myzsh.git ~/.myzsh
[ -d ~/.myzsh/remotes/myzsh-dotfiles ] || git clone https://github.com/myzsh/myzsh-dotfiles.git  ~/.myzsh/remotes/myzsh-dotfiles
[ -d ~/.myzsh/remotes/myzsh-docker ] || git clone https://github.com/myzsh/myzsh-docker.git  ~/.myzsh/remotes/myzsh-docker

# This is the base of the new zsh directory
MYZSH="$HOME/.myzsh"

# Specify a tmp directory to use across all modules
#TMPDIR="/tmp"

# This is the theme.
THEME="default"

# This is the list of modules that generate Left Primary output.
LPRIMARY=(userhost pwd svn git jobs vim)

# This is the list of modules that generate Left Secondary output.
LSECONDARY=(gettime exitcode)

# This is the list of modules that generate Right Primary output.
RPRIMARY=(ipaddr)

# This is the list of modules that generate Right Secondary output.
RSECONDARY=(getdate)

# This is the title of the terminal
TITLE=(pwd)

# This is the list of modules that get processed once at shell start.
# They shouldn't generate output.
EXTRA=(ssh-add localbin completions lesscolors lscolors ll coloncolon longcmd safe-paste tmux history alwaystmux cdtmp dotfiles docker)

PR_PRIMARY='$PR_RED'

################################################################################
# This kicks off our processing now that we have variables
source "$MYZSH/init"
