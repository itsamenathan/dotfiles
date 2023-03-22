# antidote install
[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Tell tmux what color to use
export COLOR="CYAN"

source ~/.p10k.zsh

zstyle ':completion:*' menu select
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':omz:plugins:ssh-agent' agent-forwarding yes

# antidote setup
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
source <(antidote init)

# antidote plugins
antidote bundle <<EOBUNDLES
  romkatv/powerlevel10k

  sorin-ionescu/prezto path:modules/completion
  zsh-users/zsh-autosuggestions

  ohmyzsh/ohmyzsh path:lib
  ohmyzsh/ohmyzsh path:plugins/fzf
  ohmyzsh/ohmyzsh path:plugins/git
  ohmyzsh/ohmyzsh path:plugins/ssh-agent
  ohmyzsh/ohmyzsh path:plugins/brew
  ohmyzsh/ohmyzsh path:plugins/common-aliases

  zpm-zsh/ls kind:defer
  zpm-zsh/material-colors


  $HOME/.zsh_conf/plugins/alias
  $HOME/.zsh_conf/plugins/hosts
  $HOME/.zsh_conf/plugins/coloncolon

  # defer
  $HOME/.zsh_conf/plugins/alwaystmux kind:defer
  zdharma-continuum/fast-syntax-highlighting kind:defer


EOBUNDLES
