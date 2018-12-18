function brew_upgrade --description 'upgrade all brew packages'
  echo 'Updating homebrew'
  brew update
  echo 'Upgrading homebrew packages'
  brew upgrade
  echo 'Clean up old homebrew packages'
  brew cleanup
end
