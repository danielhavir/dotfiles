# Kubernetes
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

function pod-ssh
	set pod_name (kubectl get pods -o=name | grep "$argv[1]" | cut -c 5-)
	kubectl exec -it "$pod_name" bash
end