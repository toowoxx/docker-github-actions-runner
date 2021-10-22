from archlinux

run pacman -Syu --noconfirm --needed curl gcc

run curl -L https://dot.net/v1/dotnet-install.sh | bash -s -- -c Current

run useradd -d /actions-runner -m -s /bin/bash github
user github
workdir /actions-runner
run curl -L https://github.com/actions/runner/releases/download/v2.278.0/actions-runner-linux-x64-2.278.0.tar.gz > runner.tar.gz
run tar -xzvf runner.tar.gz

add entrypoint.sh /

entrypoint /entrypoint.sh

