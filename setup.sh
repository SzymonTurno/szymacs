#!/usr/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ~
HOME_DIR=$(pwd)
EMACS_DIR="${HOME_DIR}/.emacs.d"

mkdir -p ${EMACS_DIR}
mkdir -p ${EMACS_DIR}/themes
mkdir -p ${EMACS_DIR}/misc
mkdir -p ${EMACS_DIR}/backup
cp ${SCRIPT_DIR}/init.el ${EMACS_DIR}/
cp ${SCRIPT_DIR}/themes/* ${EMACS_DIR}/themes/
cp ${SCRIPT_DIR}/misc/* ${EMACS_DIR}/misc/
git clone https://github.com/emacs-tree-sitter/elisp-tree-sitter.git
cd elisp-tree-sitter
git submodule update --init --recursive
