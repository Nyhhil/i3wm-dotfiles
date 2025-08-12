#!/bin/bash

# --- Script de Instalación de Paquetes ---

log_info() {
    echo -e "\n\e[1;34m[INFO]\e[0m $1"
}

log_success() {
    echo -e "\e[1;32m[SUCCESS]\e[0m $1"
}

log_error() {
    echo -e "\e[1;31m[ERROR]\e[0m $1"
}

# La ubicación del archivo de lista de paquetes.
PKG_LIST="aur-pkglist.txt"

# --- Verificación de Requisitos ---
if ! command -v pacman &> /dev/null; then
    log_error "pacman no está instalado. ¿Estás en un sistema basado en Arch Linux?"
    exit 1
fi

if [ ! -f "$PKG_LIST" ]; then
    log_error "El archivo de lista de paquetes '$PKG_LIST' no se encontró."
    exit 1
fi

log_info "Actualizando la base de datos de paquetes..."
sudo pacman -Syu --noconfirm

# --- Instalación del AUR Helper (yay) si no existe ---
if ! command -v yay &> /dev/null; then
    log_info "Instalando yay (AUR helper)..."
    sudo pacman -S --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - > /dev/null # Regresar al directorio anterior de forma silenciosa
    rm -rf /tmp/yay
    log_success "yay ha sido instalado."
else
    log_info "yay ya está instalado."
fi

# --- Instalación de los Paquetes ---
log_info "Instalando paquetes desde $PKG_LIST..."

yay -S --needed --noconfirm - < "$PKG_LIST"

if [ $? -eq 0 ]; then
    log_success "Todos los paquetes han sido instalados con éxito."
else
    log_error "Algunos paquetes no pudieron ser instalados. Revisa la salida de errores."
fi