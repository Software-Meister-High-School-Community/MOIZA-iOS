#!/bin/sh

brew install cocoapods
INSTALL_DIR=$PWD curl -Ls https://install.tuist.io | bash

$INSTALL_DIR/tuist generate
$INSTALL_DIR/pod install

