function brew_outdated_casks --description 'find outdated casks'
  echo (brew cask list | grep -v macvim | xargs brew cask info | grep -3 Not | grep ": " | cut -f 1 -d ":")
end
