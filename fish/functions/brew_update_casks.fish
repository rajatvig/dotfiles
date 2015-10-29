function brew_update_casks --description 'update outdated casks'
  set -x _outdated_casks (brew_outdated_casks)

  echo "Outdated Casks $_outdated_casks"

  set -x _outdated_cask_names (echo $_outdated_casks | gsed "s/ /\n/g")

  for val in $_outdated_cask_names
    if [ $val ]
      rm -rf /opt/homebrew-cask/Caskroom/$val
      brew cask install $val
    end
  end
end
