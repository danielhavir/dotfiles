# Kubernetes
alias kgp="kubectl get pods"
alias kgd="kubectl get deployments"
alias kgj="kubectl get jobs"

function watch-pod
	watch "kubectl get pods | grep $argv[1]"
end

function pod-logs
	set pod_name (kubectl get pods -o=name | grep "$argv[1]" | cut -c 5-)
	kubectl logs -f "$pod_name"
end

function delete-job
	set job_name (kubectl get jobs -o=name | grep "$argv[1]" | cut -c 11-)
	kubectl delete job "$job_name"
end

function delete-pod
	set pod_name (kubectl get pods -o=name | grep "$argv[1]" | cut -c 5-)
	kubectl delete pods "$pod_name"
end

function delete-dep
	set deployment_name (kubectl get deployments -o=name | grep "$argv[1]" | cut -c 23-)
	kubectl delete deployment "$deployment_name"
end

function edit-dep
	set deployment_name (kubectl get deployments -o=name | grep "$argv[1]" | cut -c 23-)
	kubectl edit "deployment/$deployment_name"
end

function pod-ssh
	set pod_name (kubectl get pods -o=name | grep "$argv[1]" | cut -c 5-)
	kubectl exec -it "$pod_name" -- bash
end

function count-pods
	if test (count $argv) -gt 1
		watch "kubectl get pods | grep \"$argv[1]\" | grep -c \"$argv[2]\""
	else if test (count $argv) -gt 0
		watch "kubectl get pods | grep \"$argv[1]\" | grep -c \"Running\""
	else
		echo "Please specify deployment name, and optionally state (\"Running\" by default)"
	end
end

function delete-pods
    if test (count $argv) -gt 1
		kubectl get pods | grep "$argv[1]" | grep "$argv[2]" | awk '{print $1}' | xargs kubectl delete pod
	else if test (count $argv) -gt 0
		kubectl get pods | grep "$argv[1]" | awk '{print $1}' | xargs kubectl delete pod
	else
		echo "Please specify deployment name"
	end
end
