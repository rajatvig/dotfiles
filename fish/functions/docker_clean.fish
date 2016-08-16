function docker_clean
    docker rm (docker ps -aq)
    docker rmi (docker images -aq)
    docker volume rm (docker volume ls -q)
    docker network rm (docker network ls -q)
end

