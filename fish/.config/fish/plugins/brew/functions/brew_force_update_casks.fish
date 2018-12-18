function brew_force_update_casks --description 'force update casks that are marked as latest'
  set -x _brew_list (brew cask list | grep -Fv '(!)')

  for formula in $_brew_list
    set -x _info_tmp (brew cask info $formula)
    set -x _info (echo $_info_tmp | head -n 3 | grep latest)

    if count $_info > /dev/null
      brew cask reinstall $formula
    end
  end
end
