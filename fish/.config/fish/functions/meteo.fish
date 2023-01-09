function meteo --wraps='curl -sl wttr.in/liege' --description 'alias meteo curl -sl wttr.in/liege'
  curl -sl wttr.in/liege $argv; 
end
