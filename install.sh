#! /usr/bin/env bash

SRC_DIR=$(cd $(dirname $0) && pwd)

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  SCHEMES_DIR="/usr/share/color-schemes"
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  LOOKFEEL_DIR="/usr/share/plasma/look-and-feel"
  KVANTUM_DIR="/usr/share/Kvantum"
  WALLPAPER_DIR="/usr/share/wallpapers"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  KVANTUM_DIR="$HOME/.config/Kvantum"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
fi

THEME_NAME=Lavanda
LATTE_DIR="$HOME/.config/latte"

COLOR_VARIANTS=('-Light' '-Dark')

cp -rf "${SRC_DIR}"/configs/Xresources "$HOME"/.Xresources

mkdir -p                                                                                     ${AURORAE_DIR}
mkdir -p                                                                                     ${SCHEMES_DIR}
mkdir -p                                                                                     ${PLASMA_DIR}
mkdir -p                                                                                     ${LOOKFEEL_DIR}
mkdir -p                                                                                     ${KVANTUM_DIR}
mkdir -p                                                                                     ${WALLPAPER_DIR}

install() {
  local name=${1}
  local color=${2}

  [[ ${color} == '-Dark' ]] && local ELSE_COLOR='Dark'
  [[ ${color} == '-Light' ]] && local ELSE_COLOR='Light'

  local AURORAE_THEME="${AURORAE_DIR}/${name}${color}"
  local PLASMA_THEME="${PLASMA_DIR}/${name}${color}"
  local LOOKFEEL_THEME="${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${color}"
  local SCHEMES_THEME="${SCHEMES_DIR}/${name}${ELSE_COLOR}${ELSE_THEME}.colors"
  local KVANTUM_THEME="${KVANTUM_DIR}/${name}${ELSE_THEME}"
  local WALLPAPER_THEME="${WALLPAPER_DIR}/${name}${color}"
  local LATTE_THEME="${LATTE_DIR}/${name}.layout.latte"

  [[ -d ${AURORAE_THEME} ]] && rm -rf ${AURORAE_THEME}
  [[ -d ${PLASMA_THEME} ]] && rm -rf ${PLASMA_THEME}
  [[ -d ${LOOKFEEL_THEME} ]] && rm -rf ${LOOKFEEL_THEME}
  [[ -f ${SCHEMES_THEME} ]] && rm -rf ${SCHEMES_THEME}
  [[ -d ${KVANTUM_THEME} ]] && rm -rf ${KVANTUM_THEME}
  [[ -d ${WALLPAPER_THEME} ]] && rm -rf ${WALLPAPER_THEME}
  [[ -f ${LATTE_THEME} ]] && rm -rf ${LATTE_THEME}

  cp -r ${SRC_DIR}/aurorae/${name}${color}                                                   ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/${name}${ELSE_COLOR}${ELSE_THEME}.colors                    ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/Kvantum/${name}${ELSE_THEME}                                              ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/${name}${color}                                       ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/icons                                                 ${PLASMA_THEME}
  cp -r ${SRC_DIR}/color-schemes/${name}${ELSE_COLOR}${ELSE_THEME}.colors                    ${PLASMA_THEME}/colors
  cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${color}               ${LOOKFEEL_DIR}
  cp -r ${SRC_DIR}/wallpaper/${name}${color}                                                 ${WALLPAPER_DIR}
  mkdir -p                                                                                   ${PLASMA_THEME}/wallpapers
  cp -r ${SRC_DIR}/wallpaper/${name}${color}                                                 ${PLASMA_THEME}/wallpapers
  if [[ -d ${LATTE_THEME} ]]; then
    cp -r ${SRC_DIR}/latte-dock/${name}.layout.latte                                         ${LATTE_THEME}
    cp -r ${SRC_DIR}/latte-dock/${name}_x2.layout.latte                                      ${LATTE_THEME}
  fi
}

echo "Installing '${THEME_NAME} kde themes'..."

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  install "${name:-${THEME_NAME}}" "${color}"
done

echo "Install finished..."
