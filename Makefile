run_container:
	docker run --rm -v /home/adamp/Uczelnia/sem9/large_scale_computing/lab5/.aws:/root/.aws awscli &

create_cluster:
	kind create cluster --name my-k8s-cluster

delete_cluster:
	kind delete cluster -n my-k8s-cluster

configure_cluster:
	helm repo add nfs-ganesha-server-and-external-provisioner https://kubernetes-sigs.github.io/nfs-ganesha-server-and-external-provisioner/
	helm install my-release nfs-ganesha-server-and-external-provisioner/nfs-server-provisioner --set=storageClass.name=my-nfs-storage

run_cluster: create_cluster configure_cluster
	kubectl apply -f my-pvc.yaml
	kubectl apply -f my-deployment.yaml
	kubectl apply -f my-service.yaml
