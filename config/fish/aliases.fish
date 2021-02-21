# List aliases
alias l "ls -alt"
alias ld "ls -ld */"
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

function countf
  find "$argv[1]" -type f | wc -l
end

# Ping
alias pingg "ping google.com -c 10"

# Tmux
alias tm "tmux"

# Github
alias g "git"
alias gs "git status"
alias gadd "git add"
alias gpo "git push origin"
alias gco "git checkout"

function commit
  git commit -m "$argv[1]"
end

# Google Cloud
alias gssh "gcloud compute ssh"
alias gscp "gcloud compute scp"
alias glist "gcloud compute instances list"
alias gstart "gcloud compute instances start"
alias gstop "gcloud compute instances stop"

# nVidia
alias smi "nvidia-smi -l 1"

# Docker
alias d "docker"
alias dco "docker container"
alias dim "docker image"
