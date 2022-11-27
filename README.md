# My personal dotfiles
To list installed files:
```bash
apt list --manual-installed | sed 's/\// /' | awk '{print $1}' > list.txt
```
