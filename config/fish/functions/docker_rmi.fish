function docker_rmi
  docker images -a | awk '{ print $1,$3 }' | grep $argv | awk '{print $2}' | xargs docker rmi -f
end
