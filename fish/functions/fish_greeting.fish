function fish_greeting
  function rnd_animal
    echo (ls /usr/local/share/cows/ | gshuf -n1)
  end

  set -l rnd_animal (rnd_animal)
  fortune | cowsay -f /usr/local/share/cows/$rnd_animal | toilet -f term --gay
end
