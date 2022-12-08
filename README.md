# My personal dotfiles
To list installed files:
```[[bash.md|bash]]
apt list --manual-installed | sed 's/\// /' | awk '{print $1}' > list.txt
```
## Fish
### Install Fish
https://github.com/fish-shell/fish-shell
```bash
cd fihser-shell
mkdir build; cd build
cmake ..
make
sudo make install
```

### Install Fisher
https://github.com/jorgebucaran/fisher

```bash
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```
### List of fish plugins
to install through
```bash
fisher install jorgebucaran/fisher gazorby/fish-exa ilancosman/tide@v5 edc/bass dracula/fish decors/fish-colored-man jorgebucaran/autopair.fish budimanjojo/tmux.fish jhillyerd/plugin-git patrickf1/fzf.fish reitzig/sdkman-for-fish@v1.4.0 gazorby/fish-abbreviation-tips

[Pip installation](./pip.md)
```
<!-- TODO
- tmux section
- ubuntu section
  - sudoers
  - pip install list
  - cargo list
  - lazygit 
  - neomutt
  - notmuch
  - mbsync 
  - willydeliege
  - zk -->

