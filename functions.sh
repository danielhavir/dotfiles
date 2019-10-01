# Count files
function countf() {
	find "${1}" -type f | wc -l
}

# Google Cloud #

## SSH
function gssh() {
	gcloud compute ssh ${1}
}

## List instances
function glist() {
	gcloud compute instances list
}

## Start instance
function gstart() {
	gcloud compute instances start ${1}
}

## Stop instance
function gstop() {
	gcloud compute instances stop ${1}
}

# Git #
function commit() {
	git commit -m "${1}"
}

