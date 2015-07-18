function brew_force_update_casks --description 'force update some casks that work odd'
  for val in chromium dash dropbox firefoxdeveloperedition flux google-chrome-canary google-chrome google-drive google-hangouts mou skype
    brew cask rm $val
    rm -f /Library/Caches/Homebrew/$val-latest.dmg
    rm -f /Library/Caches/Homebrew/$val-latest.zip
    rm -f /Library/Caches/Homebrew/$val-latest
    rm -rf /opt/homebrew-cask/Caskroom/$val
    brew cask install $val
  end
end
