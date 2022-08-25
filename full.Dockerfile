from ubuntu:22.04

run apt-get update && apt-get upgrade -y
run apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
	wget \
	bash

# Docker
run curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

run echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

run apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get install -q -y docker-ce docker-ce-cli containerd.io

run mkdir -p /root/.docker/cli-plugins/
run curl -SL https://github.com/docker/compose/releases/download/v2.10.0/docker-compose-linux-x86_64 > /root/.docker/cli-plugins/docker-compose
run chmod 710 /root/.docker/cli-plugins/docker-compose

run useradd -d /actions-runner -m -s /bin/bash github
run usermod -a -G docker github
user github
workdir /actions-runner

# Actions runner
run curl -L https://github.com/actions/runner/releases/download/v2.296.0/actions-runner-linux-x64-2.296.0.tar.gz > runner.tar.gz
run tar -xzvf runner.tar.gz

user root
run bin/installdependencies.sh

# HashiCorp tools
run wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg

run echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list

env DEBIAN_FRONTEND=noninteractive
run apt update -y && apt install -y terraform

# Azure CLI
run curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor > /usr/share/keyrings/microsoft.gpg

run echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] \
	https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list

run apt update -y && apt install -y azure-cli

# Other tools
run apt install -y \
	ansible \
	acl \
	zsh \
	bc \
	jq

user github

add entrypoint.sh /

entrypoint /entrypoint.sh

