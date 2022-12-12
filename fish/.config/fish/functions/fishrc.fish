function fishrc --wraps='nvim /home/willefi/.config/fish/conf.fish' --wraps='nvim /home/willefi/.config/fish/config.fish' --description 'alias fishrc nvim /home/willefi/.config/fish/config.fish'
  nvim /home/willefi/.config/fish/config.fish $argv; 
end
