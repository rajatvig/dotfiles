function clean_horizon_workspace
  find . -name '*.pyc' | xargs rm
  rm -rf static/
end
