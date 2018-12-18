function reset_launchpad --description 'reset the launchpad'
  defaults write com.apple.dock ResetLaunchPad -bool true
  killall Dock
end
