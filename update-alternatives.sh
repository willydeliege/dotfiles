#!/bin/bash

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 59
echo | sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
echo | sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
echo | sudo update-alternatives --config editor
