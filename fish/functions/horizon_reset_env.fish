function horizon_reset_env
  rm -rf .tox .venv node_modules
  npm install
  rm -rf .tox
  pip install tox
  tox -e py27 --notest
  tox -e py34 --notest
  source .tox/py27/bin/activate.fish
end
