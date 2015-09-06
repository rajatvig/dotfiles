function git_rebase_from_master
  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  set -l git_branch (_git_branch_name)

  git checkout master
  git pull --rebase origin master
  git fetch --all
  git checkout $git_branch
  git rebase master
end
