CUSTOM_NVIM_PATH=/usr/local/bin/nvim
set -u
sudo update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110
sudo update-alternatives --set ex "${CUSTOM_NVIM_PATH}"
sudo update-alternatives --set vi "${CUSTOM_NVIM_PATH}"
sudo update-alternatives --set view "${CUSTOM_NVIM_PATH}"
sudo update-alternatives --set vim "${CUSTOM_NVIM_PATH}"
sudo update-alternatives --set vimdiff "${CUSTOM_NVIM_PATH}"
