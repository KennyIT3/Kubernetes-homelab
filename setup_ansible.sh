sudo apt update
sudo apt install -y git curl vim python3 python3-venv python3-pip pipx openssh-client
pipx ensurepath
pipx install --include-deps ansible
exec $SHELL
pipx install --include-deps ansible
