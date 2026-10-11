# kubectl Setup on ansible-ctrl

kubectl is run from `ansible-ctrl`, not directly from worker nodes.

## Kubeconfig

bash
export KUBECONFIG=$HOME/.kube/k3s-homelab.yaml

sudo apt install -y bash-completion

cat >> ~/.bashrc <<'EOF'

# Kubernetes homelab kubeconfig
export KUBECONFIG=$HOME/.kube/k3s-homelab.yaml

# kubectl autocomplete
source <(kubectl completion bash)

# kubectl short alias
alias k=kubectl

# autocomplete for k alias
complete -o default -F __start_kubectl k
EOF

source ~/.bashrc

k get nodes -o wide
k get pods -A
k -n lab-test get all
k -n lab-test describe svc nginx-test

