! (( $+commands[tmux] )) && { >&2 echo "zsh-tmux-auto-title: tmux not found. Please install tmux before using this plugin."; return 1 }

: ${TMUX_LOCAL_PREFIX:=z}
: ${TMUX_REMOTE_PREFIX:=a}



function _deps(){
	app="tmux"

        $(command -v $app >/dev/null 2>&1) || ( myzsh error "Couldn't find application ${app}" && return 1 )
}

[ "$IDE" = "true" ] && return 0

if [ -z "$TMUX" ]; then
	key=$TMUX_LOCAL_PREFIX
	[ -n "$SSH_CLIENT" ] && key=$TMUX_REMOTE_PREFIX
	tmux has-session -t main || tmux new-session -d -s main
	tmux set-option -g prefix C-$key
	tmux set-option -g aggressive-resize on
	tmux bind-key C-$key last-window
	tmux bind-key $key send-prefix
	tmux new-session -t main \; set-option destroy-unattached && exit
fi
# vim: filetype=zsh noexpandtab
