function meteo_full --wraps=curl\ -sl\ \'v2.wttr.in/liege\?\%s\' --description alias\ meteo_full\ curl\ -sl\ \'v2.wttr.in/liege\?\%s\'
  curl -sl 'v2.wttr.in/liege?%s' $argv; 
end
