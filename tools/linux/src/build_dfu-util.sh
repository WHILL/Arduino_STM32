#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

sudo apt-get build-dep dfu-util
sudo apt-get install build-essentials
sudo apt-get install libusb-1.0-0-dev
sudo apt-get install autoconf automake autotools-dev

cd $SCRIPT_DIR/dfu-util
./autogen.sh
./configure
make
cp src/dfu-util $SCRIPT_DIR/../../linux/dfu-util
cp src/dfu-suffix $SCRIPT_DIR/../../linux/dfu-util
cp src/dfu-prefix $SCRIPT_DIR/../../linux/dfu-util

