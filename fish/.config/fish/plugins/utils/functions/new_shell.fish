function new_shell
  nohup /Applications/Alacritty.app/Contents/MacOS/alacritty --working-directory (pwd) > /dev/null & disown
end
