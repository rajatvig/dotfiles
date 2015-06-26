function pyenv_install
  function _sdk_path
    echo (xcrun --show-sdk-path)
  end

  set -l CFLAGS -I(_sdk_path)/include
  env CFLAGS="$CFLAGS" pyenv install $argv
end
