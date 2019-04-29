# Based on:
- https://www.tonymacx86.com/threads/guide-asus-rog-g551-552-gl551-552-series-skylake-i7-6700hq-hd-530-using-clover-uefi.195422/
- https://www.tonymacx86.com/threads/guide-asus-rog-gl502vs-skylake-i7-6700hq-gtx-1070-sierra-10-12-4.221056/

# Working
- Battery
- Sleep
- GPU
- Touchpad (Supports gestures)
- USB 2.0/3.0
- Speakers and internal mic
- WebCam
- Ethernet
- HDMI
- SD Card slot
- Display Port
- Brightness Control
- Keyboard Backlight Control

# Not working:
- Stock Wi-fi (Driver for Intel still in development)

# BIOS
Reboot and access the BIOS setup by pressing F2
- Disable Fastboot (if available)
- Disable Secure Boot
- Disable VT-d
- Disable Intel Virtualization Technology

# Post installation
## I. Preparation
1. Move folder Guide-ROG to you Desktop **(Do not rename it!)**
2. Some of the processes that could be automated - I automate. To work with them, run the following command in the terminal: ` # chmod ugo+x ~/Desktop/Guide-ROG/terminal-side/*.sh`
## II.I. Patching DSDT
1. Turn on your laptop and boot the Clover bootloader.
2. Highlight the OS X disk and press "F4" and "FN + F4" to generate the native ACPI files. _(Note: You won’t see anything while pressing F4 - the files are generated silently)_
3. Mount EFI partition with `~/Desktop/Guide-ROG/software/EFI Mounter v3.app` programm
4. Check the folder **EFI/Clover/ACPI/origin** (There should be files)
5. Open terminal _(Launchpad :: Utilites :: Terminal)_ and run command: `bash ~/Desktop/Guide-ROG/terminal-side/ACPI-start.sh` _(You may need to enter your password)_
6. Script should open the Finer in the "~/Desktop/origin" folder and run the "DSDT.dsl" file in the MaciASL program
>Note: Now we are going to edit this file and compile it back again to use it to load with your system later. It is really important that you don’t make mistake here. You can click on “Compile” to check if you extracted the DSL files correctly. Warnings doesn’t matter but errors do. If you got an error here it means you disassembled the files wrong. Now there are many edits which we are going to do with this file. After each one you can click on “Compile” to check for errors.
7. Before patching, open MaciASL. Go to the program’s preferences and add this source: http://raw.github.com/RehabMan/Laptop-DSDT-Patch/master
8. Search for ‘GFX0’ and replace all with ‘IGPU’ _(CMD + F)_
9. Brightness control under FN Keys:
- Search "**Method (_Q0E, 0, NotSerialized)**" and insert "**If...**" code:
```
        Method (_Q0E, 0, NotSerialized)
        {
            If (ATKP)
            {
               \_SB.ATKD.IANE (0x20)
            }
            ...
        }
```
- Search '**Method (_Q0F, 0, NotSerialized)**' and insert '**If...**' code
```
        Method (_Q0F, 0, NotSerialized)
        {
            If (ATKP)
            {
                \_SB.ATKD.IANE (0x10)
            }
            ...
        }
```
10. Keyboard Backlight Patch:
Open file "**KeyboardBacklight16.txt**" inside "**Guide-ROG/patches**" Folder and copy content to
MaciASL => "Patch" => "Patch Text"; Click "Apply"
11. Click on Patch and apply the following patches (Must use Internet connection):
- [syn] Rename _DSM methods to XDSM
- [bat] Asus G75VW
- [sys] Fix _WAK Arg0 v2
- [sys] Fix _WAK IAOE (If required)
- [sys] Fix Mutex with non-zero SyncLevel
- [sys] Fix PNOT/PPNT
- [sys] IRQ Fix
- [sys] OS Check Fix (Windows 8)
- [sys] SMBUS Fix
- [sys] Skylake LPC
- [usb] USB3_PRW 0x0D Skylake (instant wake)
12. Click Compile and if you have any errors (warnings don’t matter) clear them by using the patching guide above. Save the file as: DSDT.aml and file format: ACPI Machine Language Binary.

# SSDT-1 <= Чет тут ошибки были :( ) А тут еще больше - SSDT-x4_0-Cpu0Ist

## II.II. Patching SSDT's
Open files one at a time "*.dsl": 
1. Search for "**GFX0**" and replace all with "**IGPU**"
2. Click Compile and if you have any errors (warnings don’t matter) clear them by using the patching guide above. Save the file as: SSDT-*-*.aml and file format: ACPI Machine Language Binary.
3. Run command: `bash ~/Desktop/Guide-ROG/terminal-side/ACPI-ssdt.sh` (y, n)
4. Mount EFI partition and run command `bash ~/Desktop/Guide-ROG/terminal-side/ACPI-copy.sh`. OR Copy all .aml files from ~/Desktop/orign/ to you EFI/EFI/CLOVER/APCI/patched 
5. Save ~/Desktop/origin folder copy (Most likely in the future, you will need these files)

## Reboot PC => Done :) 

-2.3- Mount EFI partition
-2.4- Run commands in terminal (Ignore errors): 
`rm -fr ~/Desktop/origin-backup/origin && mv ~/Desktop/origin ~/Desktop/origin-backup && cp -R /Volumes/EFI/EFI/CLOVER/ACPI/origin ~/Desktop/origin && cd ~/Desktop/origin && find -E . -type f -not -regex "^./(DSDT|SSDT).*" -exec rm -rf {} \; && cp ~/Desktop/Guide-ROG/terminal-side/refs.txt ~/Desktop/origin && printf "\n\n\nNow enter you password:\n\n\n" && sudo cp ~/Desktop/Guide-ROG/terminal-side/iasl /usr/bin && printf "\n\nDONE\n\n" && open ./`


