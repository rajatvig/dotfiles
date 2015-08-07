function git_clean_branches
  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  git branch | grep -v (_git_branch_name) | xargs git branch -D
end
