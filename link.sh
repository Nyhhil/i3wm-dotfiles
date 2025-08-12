#!/bin/bash

# Define el directorio de dotfiles (donde se ejecuta el script)
DOTFILES_DIR=$(pwd)

# Define el directorio de destino
CONFIG_DIR="$HOME/.config"

# --- Carpetas a enlazar ---
declare -a CONFIG_FOLDERS=(
    "alacritty"
    "i3"
    "i3blocks"
    "i3status"
    "picom"
    "polybar"
    "rofi"
    "scripts"
)

# --- Creación de enlaces simbólicos ---
echo "Creando enlaces simbólicos en $CONFIG_DIR..."

for folder in "${CONFIG_FOLDERS[@]}"; do
    SOURCE_PATH="$DOTFILES_DIR/$folder"
    DEST_PATH="$CONFIG_DIR/$folder"

    # Verifica si la carpeta de destino ya existe
    if [ -e "$DEST_PATH" ]; then
        echo "Eliminando carpeta existente: $DEST_PATH"
        rm -rf "$DEST_PATH"
    fi

    # Crea el enlace simbólico
    echo "Creando enlace simbólico para: $SOURCE_PATH -> $DEST_PATH"
    ln -s "$SOURCE_PATH" "$DEST_PATH"
done

echo "Enlaces simbólicos creados con éxito."