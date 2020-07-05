[ -d ~/.myzsh ] || git clone https://github.com/myzsh/myzsh.git ~/.myzsh
[ -d ~/.myzsh/remotes/myzsh-docker ] || git clone https://github.com/myzsh/myzsh-docker.git  ~/.myzsh/remotes/myzsh-docker
[ -d ~/.myzsh/remotes/myzsh-jimshoe ] || git clone https://github.com/itsamenathan/myzsh-jimshoe.git  ~/.myzsh/remotes/myzsh-jimshoe

# Set color of zsh and tmux
export COLOR="CYAN"

# This is the base of the new zsh directory
MYZSH="$HOME/.myzsh"

# Specify a tmp directory to use across all modules

# This is the theme.
THEME="default"

# This is the list of modules that generate Left Primary output.
LPRIMARY=(pwd svn git jobs vim terraform-workspace)

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
EXTRA=(jimshoe ssh-add localbin completions lesscolors lscolors ll coloncolon longcmd safe-paste tmux history alwaystmux docker grepcolors realpath)

PR_PRIMARY="\$PR_$COLOR"

################################################################################
# This kicks off our processing now that we have variables
source "$MYZSH/init"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
