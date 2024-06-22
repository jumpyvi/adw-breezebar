#! /usr/bin/env bash

SRC_DIR=$(cd $(dirname $0) && pwd)

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  SCHEMES_DIR="/usr/share/color-schemes"
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  KVANTUM_DIR="/usr/share/Kvantum"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  KVANTUM_DIR="$HOME/.config/Kvantum"
fi

THEME_NAME=adw-breezebar

COLOR_VARIANTS=('-Light' '-Dark')

cp -rf "${SRC_DIR}"/configs/Xresources "$HOME"/.Xresources

mkdir -p                                                                                     ${AURORAE_DIR}
mkdir -p                                                                                     ${SCHEMES_DIR}
mkdir -p                                                                                     ${PLASMA_DIR}
mkdir -p                                                                                     ${KVANTUM_DIR}

install() {
  local name=${1}
  local theme=${2}
  local color=${3}

  [[ ${color} == '-Dark' ]] && local ELSE_COLOR='Dark'
  [[ ${color} == '-Light' ]] && local ELSE_COLOR='Light'

  local AURORAE_THEME="${AURORAE_DIR}/${name}${theme}${color}"
  local PLASMA_THEME="${PLASMA_DIR}/${name}${theme}${color}"
  local SCHEMES_THEME="${SCHEMES_DIR}/${name}${ELSE_THEME}${ELSE_COLOR}.colors"
  local KVANTUM_THEME="${KVANTUM_DIR}/${name}${ELSE_THEME}"

  [[ -d ${AURORAE_THEME} ]] && rm -rf ${AURORAE_THEME}
  [[ -d ${PLASMA_THEME} ]] && rm -rf ${PLASMA_THEME}
  [[ -f ${SCHEMES_THEME} ]] && rm -rf ${SCHEMES_THEME}
  [[ -d ${KVANTUM_THEME} ]] && rm -rf ${KVANTUM_THEME}

  cp -r ${SRC_DIR}/aurorae/${name}${theme}${color}                                           ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/${name}${ELSE_THEME}${ELSE_COLOR}.colors                    ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/Kvantum/${name}${ELSE_THEME}                                              ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/${name}${theme}${color}                               ${PLASMA_DIR}

  cp -r ${SRC_DIR}/color-schemes/${name}${ELSE_THEME}${ELSE_COLOR}.colors                    ${PLASMA_THEME}/colors

}

echo "Installing '${THEME_NAME} kde themes'..."

for theme in "${themes[@]:-${THEME_VARIANTS[@]}}"; do
  for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
    install "${name:-${THEME_NAME}}" "${theme}" "${color}"
  done
done

echo "Install finished..."
