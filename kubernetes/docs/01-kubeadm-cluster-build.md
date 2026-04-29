# Kubernetes kubeadm Cluster Build

## Architecture

- rhel9: Kubernetes control plane
- rhel8: Kubernetes worker
- container runtime: containerd
- bootstrap tool: kubeadm
- CNI: Calico
- test app: nginx exposed with NodePort

## Build Phases

1. Install and configure containerd
2. Install kubeadm, kubelet, kubectl
3. Initialize rhel9 as the control plane
4. Join rhel8 as worker
5. Install a CNI plugin
6. Deploy nginx test workload
7. Expose nginx using NodePort
8. Validate the cluster
