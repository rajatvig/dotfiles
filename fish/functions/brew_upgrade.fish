function brew_upgrade --description 'upgrade all casks'
  echo 'Updating homebrew'
  brew update
  echo 'Upgrading homebrew packages'
  brew upgrade --all
  echo 'Clean up old homebrew packages'
  brew cleanup
  echo 'Outdated Casks'
  echo (brew cask list | grep -v macvim | xargs brew cask info | grep -3 Not | grep ": " | cut -f 1 -d ":")
end