function brew_force_update_casks --description 'force update some casks that work odd'
  for val in chromium google-chrome-canary google-drive skype
    brew cask rm $val
    rm -f /Library/Caches/Homebrew/$val-latest.dmg # google-chrome-canary google-drive skype
    rm -f /Library/Caches/Homebrew/$val-latest # chromium
    rm -rf /opt/homebrew-cask/Caskroom/$val
    brew cask install $val
  end
end
