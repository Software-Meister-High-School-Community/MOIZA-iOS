#!/bin/sh

sudo gem install cocoapods
INSTALL_DIR=$PWD curl -Ls https://install.tuist.io | bash

$INSTALL_DIR/rm -rf Podfile.lock
$INSTALL_DIR/tuist generate
$INSTALL_DIR/pod install

