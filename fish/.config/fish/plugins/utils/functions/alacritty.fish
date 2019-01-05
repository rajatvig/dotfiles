function alacritty
  nohup /Applications/Alacritty.app/Contents/MacOS/alacritty --working-directory (pwd) -e /usr/local/bin/$argv > /dev/null & disown
end
