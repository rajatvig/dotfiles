function horizon_clean_workspace
  find . -name '*.pyc' | xargs rm
  rm -rf static/
end
