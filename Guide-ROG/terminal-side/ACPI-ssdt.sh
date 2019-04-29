#!/bin/bash
rm -fr ~/Desktop/origin/SSDT.dsl
rm -fr ~/Desktop/origin/SSDT.aml
./ssdtPRGen.sh
cp ~/Library/ssdtPRGen/ssdt.dsl ~/Desktop/origin/SSDT.dsl
cp ~/Library/ssdtPRGen/ssdt.aml ~/Desktop/origin/SSDT.aml

# Done
printf "\n\n\n          DONE\n------------------------\n\n\n";
