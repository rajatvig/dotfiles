function brew_removed_casks --description 'find removed casks'
  echo (brew cask list | grep "!")
end
