function horizon_git_review
  git checkout master
  git fetch --all
  git pull
  git review -d $argv
  git rebase master
end
