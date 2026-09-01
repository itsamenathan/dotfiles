! (( $+commands[tmux] )) && { >&2 echo "zsh-tmux-auto-title: tmux not found. Please install tmux before using this plugin."; return 1 }

: ${TMUX_LOCAL_PREFIX:=z}
: ${TMUX_REMOTE_PREFIX:=a}
: ${TMUX_DEFAULT_SESSION:=main}
: ${TMUX_AUTO_START:=ssh}

function tm() {
	local key="$TMUX_LOCAL_PREFIX"
	[ -n "$SSH_CLIENT" ] && key="$TMUX_REMOTE_PREFIX"

	tmux has-session -t "$TMUX_DEFAULT_SESSION" 2>/dev/null || tmux new-session -d -s "$TMUX_DEFAULT_SESSION"
	tmux set-option -g prefix "C-$key"
	tmux set-option -g aggressive-resize on
	tmux set-option -g mouse on
	tmux bind-key "C-$key" last-window
	tmux bind-key "$key" send-prefix

	if [ -n "$TMUX" ]; then
		tmux switch-client -t "$TMUX_DEFAULT_SESSION"
	else
		tmux attach-session -t "$TMUX_DEFAULT_SESSION"
	fi
}

# Wrap ssh so the outer/local tmux doesn't fight the remote tmux over mouse
# reporting: hand mouse control to the remote session for the life of the
# connection, then always restore it locally and reset any raw mouse-tracking
# escapes left on the terminal, even if the connection dies (broken pipe, etc).
function ssh() {
	local toggled=0
	if [ -n "$TMUX" ] && [ -z "$SSH_CLIENT" ]; then
		tmux set-option -g mouse off
		toggled=1
	fi

	command ssh "$@"

	if [ "$toggled" -eq 1 ]; then
		printf '\033[?1000l\033[?1002l\033[?1003l\033[?1006l'
		tmux set-option -g mouse on
	fi
}

if [[ -z "$TMUX" && -o interactive ]]; then
	case "${(L)TMUX_AUTO_START}" in
		on|1|true|yes)
			tm
			;;
		ssh|remote)
			[ -n "$SSH_CLIENT" ] && tm
			;;
		*)
			;;
	esac
fi
# vim: filetype=zsh noexpandtab
