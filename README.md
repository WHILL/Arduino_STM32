Arduino STM32
=============

## Notice
This software is experimental and a work in progress.
Under no circumstances should these files be used in relation to any critical system(s).
Use of these files is at your own risk.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Summary:
This repo contains the "Hardware" files to support STM32 based boards on Arduino version 1.8.x (some older versions may also work) including [LeafLabs Maple, and Maple mini](http://www.leaflabs.com/about-maple/), and other generic STM32F103 boards.

***PRIMARY SUPPORT FORUM: http://www.stm32duino.com/***

***We are also on Gitter https://gitter.im/stm32duino/Lobby/***
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/stm32duino/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Background & Support:
* Based on https://github.com/bobc/maple-asp, which is in turn based on LibMaple by Leaflabs
* **Please read the wiki (https://github.com/rogerclarkmelbourne/Arduino_STM32/wiki) for full details**
* See also my blog: http://www.rogerclark.net/stm32f103-and-maple-maple-mini-with-arduino-1-5-x-ide/
* **NEW: Main support site for using STM32 boards with the Arduino IDE: http://www.stm32duino.com/**
* Original LeafLabs "Docs:" http://docs.leaflabs.com/docs.leaflabs.com/index.html


**YouTube Videos:**
* 20141116: [Arduino 1.5.8 IDE with STM32 board](https://www.youtube.com/watch?v=-zwGnytGT8M)
* 20150413: [STM32 for Arduino 1.6.2 or newer (update)](https://www.youtube.com/watch?v=TePglhSkghg)
* 20150419: [Uploading via USB to Serial to STM32F103 boards](https://www.youtube.com/watch?v=G_RF0a0hrak)

## Additional Links & Info:
* https://www.hackster.io/rayburne/4-dollar-90-mips-32-bit-72-mhz-arm-arduino

## Purchase info:
### Entry level boards
* [Ebay search for "arduino maple"](http://www.ebay.com/sch/i.html?_from=R40&_sacat=0&LH_BIN=1&_nkw=arduino+maple&_sop=15) (currently costs <$5 with shipping)
* [AliExpress search for "leaflabs maple"](http://www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20150607085526&SearchText=leaflabs+maple)

### Bigger boards (You need to load the stm32duino bootloader)
Some suppliers have this board e.g.
* [ STM32F103VET ](http://www.ebay.com.au/itm/1PCS-STM32F103VET6-ARM-STM32-Minimum-System-Development-Board-Arduino-M77-/301433302819)
* [There is also a STM32F103ZET board which also works, however they are not always available. They have been listed as "STM32F103ZET6 Minimum System Development Board ARM STM32 Cortex-m3 M75"](http://www.ebay.com.au/itm/1pcs-STM32F103ZET6-Minimum-System-Development-Board-ARM-STM32-Cortex-m3-M75-/291305557264)



## Configure BOOT0/RESET pins from DTR/RTS
_Added by WHILL Inc_

If you would like to configure BOOT0/RESET pins by remote, This circuit maybe helpful to enter bootloader mode automatically. 
Also if you choose Serial as upload method on Arduino IDE, in this repositry runs reset command by flipping DTR/RTS lines when you upload a sketch.  (Only on Linux currently)
Besides this allows flash firmware remotely without STM32duino bootloader. On rare ossasions STM32Bootloader fails to go into DFU mode. This may useful if you hope more stability especially application hard to touch reset button or BOOT config pins.

<img src="https://user-images.githubusercontent.com/2618822/62589256-9eb1be80-b903-11e9-805e-744f82469350.png" width="80%">

1uF capacitor and 100k resistor on Reset line make delay on reset.

Following commands are used to reset or get into bootloader mode.
 - Reset : `Arduino_STM32/tools/linux/serial/upload-reset-flow`
 - Into Bootloader: `Arduino_STM32/tools/linux/serial/upload-set-bootmode`

## Restriction of the install memory region
_Added by WHILL Inc_

To use EEPROM emulator(needs 2KB for dummy EEPROM) before and after FW install from arduino IDE, modify stm32flash source code.
Update **Medium-density** firmware size as 62KB for **STM32F103C8**, it defined in ```dev_table.c```.

```
{0x410, "Medium-density"    , 0x20000200, 0x20005000, 0x08000000, 0x0800F800,  4, 1024, 0x1FFFF800, 0x1FFFF80F, 0x1FFFF000, 0x1FFFF800},
```

And update ```main.c``` of stm32flash to restrict erase size as firmware size (commit:[9553961b41f0c9b5562a4436a5860e295099f6e8](https://github.com/WHILL/Arduino_STM32/commit/9553961b41f0c9b5562a4436a5860e295099f6e8)).

Notice if you want to write over 62KB in **Medium-density** size, you have to update above implement.
