# Auto-sync SSH_AUTH_SOCK from tmux if inside tmux
if [[ -n "$TMUX" ]]; then
  tmux_sock=$(tmux show-environment SSH_AUTH_SOCK 2>/dev/null | sed 's/^SSH_AUTH_SOCK=//')
  if [[ -n "$tmux_sock" && "$SSH_AUTH_SOCK" != "$tmux_sock" ]]; then
    export SSH_AUTH_SOCK="$tmux_sock"
  fi
fi

# Define helper function for manual sync
fix-ssh-auth() {
  if [[ -z "$TMUX" ]]; then
    echo "Not inside tmux — nothing to fix."
    return 1
  fi

  local tmux_sock=$(tmux show-environment SSH_AUTH_SOCK 2>/dev/null | sed 's/^SSH_AUTH_SOCK=//')
  if [[ -n "$tmux_sock" ]]; then
    export SSH_AUTH_SOCK="$tmux_sock"
    echo "SSH_AUTH_SOCK updated to: $SSH_AUTH_SOCK"
  else
    echo "tmux does not have SSH_AUTH_SOCK set."
    return 1
  fi
}

# Optional: update tmux's env with current SSH_AUTH_SOCK if freshly logged in
if [[ -n "$SSH_AUTH_SOCK" ]]; then
  tmux set-environment -g SSH_AUTH_SOCK "$SSH_AUTH_SOCK" 2>/dev/null
fi
