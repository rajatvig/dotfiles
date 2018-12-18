function brew_outdated_casks --description 'list outdated casks'
  set -x _brew_list (brew cask list | grep -Fv '(!)')

  for formula in $_brew_list
    set _new_ver (brew cask info $formula | head -n 3 | head -n 1 | cut -d' ' -f 2)
    set _cur_ver (brew cask info $formula | head -n 3 | tail -n 1 | cut -d/ -f 6 | cut -d' ' -f1)

    if test $_new_ver != $_cur_ver
      echo "$formula ($_cur_ver < $_new_ver)"
    end
  end
end
