# ubuntu 24.10
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
  signingkey = `create new key, add to github twice, auth and signing`
[gpg]
  format = ssh
[commit]
  gpgsign = true
```
