function ggpush --description 'git push origin $(branch)'
  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  set -l git_branch (_git_branch_name)
  git push origin $git_branch
end