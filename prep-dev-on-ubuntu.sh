#!/bin/bash

cat <<EOF > /root/.ssh/id_ecdsa.pub
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNSY7MS2xididJNWWTy3hvH/9OnERVW+yDDZNPS5ngORCz1j1afpmT0GreMFbvStWSzt2hC2XDnGwsO/0er5Lec= thomas@ipad
EOF

chmod 600 /root/.ssh/id_ecdsa.pub

cat <<EOF > /root/.gitconfig
[user]
  name = Thomas Vodrazka
  email = 9295830+vodrazka@users.noreply.github.com
  signingkey = /root/.ssh/id_ecdsa.pub
[gpg]
  format = ssh
[commit]
  gpgsign = true
EOF

#neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

#rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup install stable
rustup default stable
rustup component add rust-analyzer
sudo apt install -y build-essential
cargo install ripgrep fd-find

#croc
curl https://getcroc.schollz.com | bash

#golang
wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
rm go1.24.2.linux-amd64.tar.gz
cat <<\EOF >> /root/.bashrc
alias vim=nvim
export EDITOR=vim
export PATH=$PATH:/usr/local/go/bin
EOF
