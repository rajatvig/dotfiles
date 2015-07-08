function git_dir_pull --description 'run git on all directories'
  for d in (ls)
    echo "pulling $d"
    cd $d
    gup
    cd ..
    echo "done pulling $d"
  end
end
