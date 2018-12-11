function autotmux --on-variable TMUX_SESSION_NAME
    if test -n "$TMUX_SESSION_NAME" #only if set
        if test -z $TMUX #not if in TMUX
            if tmux has-session -t $TMUX_SESSION_NAME
                exec tmux new-session -t "$TMUX_SESSION_NAME"
            else
                exec tmux new-session -s "$TMUX_SESSION_NAME"
            end
        end
    end
end
