# Kubernetes
alias kubget="kubectl get"

function watch-pod() {
	 watch "kubectl get pods | grep ${1}"
}

function pod-logs() {
	pod_name=$(kubectl get pods -o=name | grep "${1}" | cut -c 5-)
	kubectl logs -f "$pod_name"
}

function delete-job() {
  job_name=$(kubectl get jobs -o=name | grep "${1}" | cut -c 11-)
	kubectl delete job "$job_name"
}

function delete-pod() {
	pod_name=$(kubectl get pods -o=name | grep "${1}" | cut -c 5-)
	kubectl delete pods "$pod_name"
}

function delete-dep() {
	deployment_name=$(kubectl get deployments -o=name | grep "${1}" | cut -c 23-)
	kubectl delete deployment "$deployment_name"
}

function edit-dep() {
	deployment_name=$(kubectl get deployments -o=name | grep "${1}" | cut -c 23-)
	kubectl edit "deployment/$deployment_name"
}

function pod-ssh() {
	pod_name=$(kubectl get pods -o=name | grep "${1}" | cut -c 5-)
	kubectl exec -it "$pod_name" bash
}