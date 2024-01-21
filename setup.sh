#!/usr/bin/bash

HOME_DIR="$1"
EMACS_DIR="$HOME_DIR/.emacs.d"

mkdir -p ${EMACS_DIR}
mkdir -p ${EMACS_DIR}/themes
mkdir -p ${EMACS_DIR}/misc
mkdir -p ${EMACS_DIR}/backup
cp ./init.el ${EMACS_DIR}/
cp ./themes/* ${EMACS_DIR}/themes/
cp ./misc/* ${EMACS_DIR}/misc/
cd ${HOME_DIR} && \
    git clone https://github.com/emacs-tree-sitter/elisp-tree-sitter.git
