function grcb --description "rebase current branch against master"
  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  set -l git_branch (_git_branch_name)

  git checkout master
  gup
  git checkout $git_branch
  git rebase master
end
