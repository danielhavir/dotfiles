#!/bin/bash

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

function count-pods() {
	num_args="$#"
	if [[ "$num_args" -gt "1" ]]
	then
		watch "kubectl get pods | grep \"${1}\" | grep -c \"${2}\""
	elif [[ "$num_args" -gt "0" ]]
	then
		watch "kubectl get pods | grep \"${1}\" | grep -c \"Running\""
	else
		echo "Please specify deployment name, and optionally state (\"Running\" by default)"
	fi
}

function delete-evicted() {
	num_args="$#"
	if [[ "$num_args" -gt "0" ]]
	then
		kubectl get pods | grep "${1}" | grep "Evicted" | awk '{print $1}' | xargs kubectl delete pod
	else
		echo "Please specify deployment name"
	fi
}
