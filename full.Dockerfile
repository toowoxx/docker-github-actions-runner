from archlinux

run pacman -Syu --noconfirm --needed \
    curl gnupg git wget bash zip \
	unzip docker go nodejs terraform packer \
	ansible acl zsh bc jq sudo base-devel \
	dotnet-runtime terraform packer

run useradd builder -m && passwd -d builder && echo "builder ALL=(ALL) ALL" > /etc/sudoers.d/builder

# Install Azure CLI
user builder
workdir /home/builder
run git clone https://aur.archlinux.org/azure-cli.git && cd azure-cli && makepkg -s --noconfirm
user root
workdir /home/builder/azure-cli
run pacman -U --noconfirm *.tar.*
workdir /

run mkdir -p /usr/lib/docker/cli-plugins/
run curl -SL https://github.com/docker/compose/releases/download/v2.10.0/docker-compose-linux-x86_64 > /usr/lib/docker/cli-plugins/docker-compose
run chmod 710 /usr/lib/docker/cli-plugins/

run useradd -d /actions-runner -m -s /bin/bash github
run usermod -a -G docker github
user github
workdir /actions-runner

# Actions runner
run curl -L https://github.com/actions/runner/releases/download/v2.296.0/actions-runner-linux-x64-2.296.0.tar.gz > runner.tar.gz
run tar -xzvf runner.tar.gz

user root
run userdel builder && rm -rf /home/builder

user github

add entrypoint.sh /

entrypoint /entrypoint.sh

