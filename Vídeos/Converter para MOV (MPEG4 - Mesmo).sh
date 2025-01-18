#!/bin/bash

# Colaboração:    Fernando Souza - https://www.youtube.com/@fernandosuporte/

clear

# -------------------------------------------------------------------------------------------------

# Verificar se os programas estão instalados:

which sed         1> /dev/null || exit 1
which ffmpeg      1> /dev/null || exit 2
which notify-send 1> /dev/null || exit 3


# -------------------------------------------------------------------------------------------------

{

readarray FILENAME <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | sed -e 's/\r//g')"

for file in "${FILENAME[@]}"; do

    file=$(echo "$file" | tr -d $'\n')
    
    ffmpeg -i "$file" -c:v mpeg4 -map 0 -q:v 0 -codec:a pcm_s16le "${file%.*}-converted.mov"
    
done

notify-send "Deu certo!" "Os arquivos foram convertidos para MOV com sucesso!" --app-name="Transform" --icon="$HOME/.local/share/icons/custom/transform-symbolic.svg"

}

exit 0
