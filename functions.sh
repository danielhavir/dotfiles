# Count files
function countf() {
	find "${1}" -type f | wc -l
}

# Git #
function commit() {
	git commit -m "${1}"
}

