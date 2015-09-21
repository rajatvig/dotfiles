function git_dir2_pull --description 'run git on all directories'
  for d in (ls)
    cd $d
    for e in (ls)
      cd $e
      echo "pulling $e"
      gup
      echo "done pulling $e"
      cd ..
    end
    cd ..
  end
end
