#!/bin/bash

sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 59
echo | sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
echo | sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/loca/bin/nvim 60
echo | sudo update-alternatives --config editor
