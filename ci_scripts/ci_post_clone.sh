#!/bin/sh

brew install cocoapods
curl -Ls https://install.tuist.io | bash

tuist generate
pod install

