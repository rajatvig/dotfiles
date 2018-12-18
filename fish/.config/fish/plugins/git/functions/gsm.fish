function gsm
  for d in (ls)
    cd $d
    git checkout master
    git fetch --all
    git pull --rebase
    cd ..
  end
end
