function brew_upgrade --description 'upgrade all brew packages'
  echo 'Updating homebrew'
  brew update
  echo 'Upgrading homebrew packages'
  brew upgrade --all
  echo 'Clean up old homebrew packages'
  brew cleanup
  brew_update_casks
  brew cask cleanup
end
