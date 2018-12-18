function drc
    docker rm (docker ps -aq)
    docker volume rm (docker volume ls -q)
    docker network rm (docker network ls -q)
end
