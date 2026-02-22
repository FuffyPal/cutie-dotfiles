# History
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# User
PS1="\[\e[38;2;255;171;185m\]\u@\h \[\e[38;2;180;200;255m\]\w\[\e[0m\]\$ "

case "$TERM" in
    xterm*|vte*)
        PS1='\[\e]0;\u@\h: \w\a\]'$PS1
        ;;
esac

# Enable Bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Alias
alias ls="ls --color=auto"
alias l="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -lha --color=auto"
alias grep="grep --color=auto"
alias helix="/bin/hx"
alias hx="/bin/hx"
alias up="sudo dnf update -y && flatpak update -y"
alias cat="/bin/lolcat"
alias comfyui="podman run  -v ~/models:/workspace/ComfyUI/models --name comfyui -p 8188:8188 -d --device nvidia.com/gpu=all --rm --security-opt=label=disable comfyui-docker:latest"


# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
