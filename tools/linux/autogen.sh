#!/bin/sh

#Copyright 2019 WHILL Inc.
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Author: Hikaru Sugiura

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "\e[33mBuilding dfu-util\e[m"
$SCRIPT_DIR/src/build_dfu-util.sh

echo "\e[33mBuilding stm32flash\e[m"
cd $SCRIPT_DIR/src/stm32flash_serial/src
make
mv stm32flash $SCRIPT_DIR/stm32flash

echo "\e[33mBuilding upload-reset\e[m"
cd $SCRIPT_DIR/src/upload-reset
gcc upload-reset.c -o upload-reset
mv upload-reset $SCRIPT_DIR/

echo "\e[33mBuilding serial\e[m"
cd $SCRIPT_DIR/src/serial
gcc upload-reset-flow.c -o upload-reset-flow
gcc upload-set-bootmode.c -o upload-set-bootmode
mv upload-reset-flow $SCRIPT_DIR/serial/
mv upload-set-bootmode $SCRIPT_DIR/serial/

echo "\e[32mDone\e[m"

