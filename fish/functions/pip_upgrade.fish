function pip_upgrade --description 'upgrade the pips; from http://stackoverflow.com/questions/2720014/upgrading-all-packages-with-pip'
  pip install -U pip  
  pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
end
