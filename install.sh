#! /usr/bin/env bash

SRC_DIR=$(cd $(dirname $0) && pwd)

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  SCHEMES_DIR="/usr/share/color-schemes"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
fi

THEME_NAME=adw-breezebar

COLOR_VARIANTS=('-Light' '-Dark')

cp -rf "${SRC_DIR}"/configs/Xresources "$HOME"/.Xresources

mkdir -p                                                                                     ${AURORAE_DIR}
mkdir -p                                                                                     ${SCHEMES_DIR}

install() {
  local name=${1}
  local theme=${2}
  local color=${3}

  [[ ${color} == '-Dark' ]] && local ELSE_COLOR='Dark'
  [[ ${color} == '-Light' ]] && local ELSE_COLOR='Light'

  local AURORAE_THEME="${AURORAE_DIR}/${name}${theme}${color}"
  local PLASMA_THEME="${PLASMA_DIR}/${name}${theme}${color}"

  [[ -d ${AURORAE_THEME} ]] && rm -rf ${AURORAE_THEME}
  [[ -d ${PLASMA_THEME} ]] && rm -rf ${PLASMA_THEME}
  [[ -f ${SCHEMES_THEME} ]] && rm -rf ${SCHEMES_THEME}

  cp -r ${SRC_DIR}/aurorae/${name}${theme}${color}                                           ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/${name}${ELSE_THEME}${ELSE_COLOR}.colors                    ${SCHEMES_DIR}


}

echo "Installing '${THEME_NAME} kde themes'..."

for theme in "${themes[@]:-${THEME_VARIANTS[@]}}"; do
  for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
    install "${name:-${THEME_NAME}}" "${theme}" "${color}"
  done
done

echo "Install finished..."
