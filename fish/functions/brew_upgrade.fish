function brew_upgrade --description 'upgrade all brew packages'
  echo 'Updating homebrew'
  brew update
  echo 'Upgrading homebrew packages'
  brew upgrade --all
  echo 'Clean up old homebrew packages'
  brew cleanup
  echo 'Outdated Casks'
  echo (brew_outdated_casks)
  brew_update_casks
end
