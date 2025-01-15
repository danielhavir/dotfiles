# List aliases
alias l="ls -alt"
alias ld="ls -ld */"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

function countf() {
	find "${1}" -type f | wc -l
}

# Ping
alias pingg="ping google.com -c 10"

# Tmux
alias tm="tmux"

# Github
alias g="git"
alias gs="git status"
alias gadd="git add"
alias gpo="git push origin"
alias gco="git checkout"

function commit() {
	git commit -m "${1}"
}

# Function to get the current Git branch or commit hash
git_current_branch() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [ -n "$ref" ]; then
    echo "${ref##refs/heads/}"
  fi
}

# Function to push the current branch to origin
gpoc() {
  git push origin "$(git_current_branch)"
}

# nVidia
alias smi="nvidia-smi -l 1"

# Docker
alias d="docker"
alias dco="docker container"
alias dim="docker image"
alias dpsa="docker ps -a"

find_container_id() {
  local container_name_part="$1"
  docker ps -a --filter "name=$container_name_part" --format "{{.ID}} {{.Names}}" | grep "$container_name_part" | head -n 1 | awk '{print $1}'
}

find_image_id() {
  local image_name_part="$1"
  docker image ls --format "{{.ID}} {{.Repository}}" | grep "$image_name_part" | awk '{print $1}'
}


