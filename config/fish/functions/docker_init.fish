function docker_init
  set -l _docker_machine_state (docker-machine status default)
  switch $_docker_machine_state
    case Stopped
      docker-machine start default
  end

  eval (docker-machine env default)
end
