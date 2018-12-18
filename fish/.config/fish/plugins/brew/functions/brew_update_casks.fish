function brew_update_casks --description 'update outdated casks'
  set -x _outdated_casks (brew_outdated_casks)
  set -x _outdated_cask_names (echo $_outdated_casks | cut -d'(' -f1 | cut -d' ' -f 1)
  echo "Outdated Casks $_outdated_cask_names"

  for val in $_outdated_cask_names
    if [ $val ]
      brew cask reinstall $val
    end
  end

  brew cask cleanup
end
