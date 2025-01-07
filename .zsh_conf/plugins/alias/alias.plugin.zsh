# aliases
#alias docker-dev='docker run -t -i -v "$PWD:/docker" --workdir=/docker'

# Package commands
if hash apt-get 2>/dev/null; then
  alias inst="sudo apt-get install"
  alias remove="sudo apt-get purge"
  alias search="apt-cache search"
  alias show="apt-cache policy"
  alias update="sudo apt-get -V dist-upgrade"
fi

if hash pacman 2>/dev/null; then
  alias inst="yay -S"
  alias remove="yay -R"
  alias search="yay -Ss"
  alias update="yay -Syyua"
fi

if hash brew 2>/dev/null; then
  alias inst="brew install"
  alias remove="brew uninstall"
  alias search="brew search"
  alias show="brew info"
  alias update="brew update && brew outdated && brew upgrade"
fi


if hash xdg-open 2>/dev/null; then
  alias "open"="/usr/bin/xdg-open"
fi

