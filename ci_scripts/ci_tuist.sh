#!/bin/sh

INSTALL_DIR=$PWD curl -Ls https://install.tuist.io | bash

$INSTALL_DIR/tuist fetch
$INSTALL_DIR/TUIST_TEST=1 tuist generate

