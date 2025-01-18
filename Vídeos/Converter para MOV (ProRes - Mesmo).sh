#!/bin/bash

# Colaboração:    Fernando Souza - https://www.youtube.com/@fernandosuporte/

clear

# -------------------------------------------------------------------------------------------------

# Verificar se os programas estão instalados:

which sed         1> /dev/null || exit 1
which ffmpeg      1> /dev/null || exit 2
which notify-send 1> /dev/null || exit 3
which tr          1> /dev/null || exit 4


# -------------------------------------------------------------------------------------------------

{

readarray FILENAME <<< "$(echo -e "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | sed -e 's/\r//g')"

for file in "${FILENAME[@]}"; do
    file=$(echo "$file" | tr -d $'\n')
    ffmpeg -i "$file" -vcodec prores_ks -qscale 0 -map 0 -acodec pcm_s16le -ac 1 -ar 22050 "${file%.*}-converted.mov"
done

notify-send "Deu certo!" "Os arquivos foram convertidos para MOV com sucesso!" --app-name="Transform" --icon="$HOME/.local/share/icons/custom/transform-symbolic.svg"

}
