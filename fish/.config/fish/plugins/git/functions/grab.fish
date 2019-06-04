function grab
  function _git_branches
    echo (git branch | grep -v master)
  end

  set -l git_branches (_git_branches)
  set -x _git_branches_list (echo $git_branches | gsed "s/ /\n/g")

  git fetch --all
  git checkout master
  gup

  for _git_branch in $_git_branches_list
    if [ $_git_branch ]
      echo "checking out $_git_branch"
      git checkout $_git_branch
      git rebase master
    end
  end

  git checkout master

end
