function docker_clean
    docker rm (docker ps -aq)
    docker volume rm (docker volume ls -q)
end

