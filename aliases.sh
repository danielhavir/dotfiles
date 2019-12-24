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

# Github
alias g="git"
alias gs="git status"
alias gadd="git add"
alias gpo="git push origin"

function commit() {
	git commit -m "${1}"
}

# Google Cloud
alias gssh="gcloud compute ssh"
alias gscp="gcloud compute scp"
alias glist="gcloud compute instances list"
alias gstart="gcloud compute instances start"
alias gstop="gcloud compute instances stop"

# nVidia
alias smi="nvidia-smi -l 1"

