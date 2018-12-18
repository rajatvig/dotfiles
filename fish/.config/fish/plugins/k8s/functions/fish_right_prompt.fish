function fish_right_prompt
    [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
    set -l ctx (kubectl config current-context 2>/dev/null)
    echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color white)"($ctx)"
end
