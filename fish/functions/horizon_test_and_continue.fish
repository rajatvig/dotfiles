function horizon_test_and_continue
  run_python3_horizon_tests; and npm run lint; and npm run test; and source .tox/py27/bin/activate.fish; and ./run_tests.sh -N --no-pep8; and git rebase --continue
end
