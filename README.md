# ubuntu 24.10
# automation
```
cd /root/
git clone git@github.com:vodrazka/dotfiles.git
cd dotfiles/
chmod +x prep-dev-on-ubuntu.sh
./prep-dev-on-ubuntu.sh
source /root/.bashrc
vim
```

```
:MasonInstall gopls
:TSInstall lua markdown
```

```
mkdir /root/code
cd /root/code
git clone git@github.com:vodrazka/rust-intro.git
git clone git@github.com:vodrazka/go_http.git
```

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```
apt install -y fzf
cat <<\EOF >> /root/.zshrc
alias vim=nvim
export EDITOR=vim
EOF
vim ~/.zshrc
```

```
wd rust golang fzf
```

```
. ~/.zshrc
```

# manual
## install neovim
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```
## install rust
* Newest manual install from rust website
```
rustup install stable
rustup default stable
rustup component add rust-analyzer
```
* Add cargo bin to path
## install golang
* Newest manual install from golang website
* Add go bin to path
## neovim optional dependencies
### ripgrep
`cargo install ripgrep`
### fd
`cargo install fd-find`
### croc
`curl https://getcroc.schollz.com | bash`

## setup gitconfig
Global gitconfig file
```
[user]
  name = Thomas Vodrazka
  email = 9295830+vodrazka@users.noreply.github.com
  signingkey = path to public key, use forwarding
[gpg]
  format = ssh
[commit]
  gpgsign = true
```
## neovim troubleshooting
### install lua treesitter
`TSInstall lua markdown`
`MasonInstall gopls`
