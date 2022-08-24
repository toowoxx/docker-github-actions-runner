from ubuntu:20.04

run apt-get update && apt-get upgrade -y
run apt-get install -y curl gcc

run useradd -d /actions-runner -m -s /bin/bash github
user github
workdir /actions-runner
run curl -L https://github.com/actions/runner/releases/download/v2.296.0/actions-runner-linux-x64-2.296.0.tar.gz > runner.tar.gz
run tar -xzvf runner.tar.gz

user root
run bin/installdependencies.sh
user github

add entrypoint.sh /

entrypoint /entrypoint.sh

