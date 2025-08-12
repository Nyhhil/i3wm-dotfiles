#!/usr/bin/env sh

# Guardar el número de actualizaciones de AUR
AUR_UPDATES=$(yay -Qu 2> /dev/null | wc -l)

# Mostrar el resultado
echo "$AUR_UPDATES"