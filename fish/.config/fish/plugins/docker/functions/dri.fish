function dri
  docker images -a | awk '{ print $1,$3 }' | grep $argv | awk '{print $2}' | xargs docker rmi -f
end
