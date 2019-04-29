#!/bin/bash

CURRENTDATE=`date +"%Y-%m-%d__%H_%M_%S__$RANDOM"`;

# Backup old origin folder
if [ -d ~/Desktop/origin ]; then
  # Create folder for old "orign" folders backups
  mkdir -p ~/Desktop/origin-backups;
  # Move old "origin" folder to backups
  mv -v ~/Desktop/origin/ ~/Desktop/origin-backups/$CURRENTDATE;
fi

# Delete if exits origin folder (etc. empty)
rm -fr ~/Desktop/origin;

# Copy ACPI files from CLOVER
cp -R /Volumes/EFI/EFI/CLOVER/ACPI/origin ~/Desktop/origin;

# Go to new origin folder
cd ~/Desktop/origin;

# Delete unnecessary files
find -E . -type f -not -regex "^./(DSDT|SSDT).*" -exec rm -rf {} \;

# Copy "refs.txt" file
cp ~/Desktop/Guide-ROG/terminal-side/refs.txt ./;

# Registration "iasl" shell application in system
if [ ! -f /usr/bin/iasl ]; then
  # Copy file iasl file to /usr/bin
  sudo cp ~/Desktop/Guide-ROG/terminal-side/iasl /usr/bin;
fi

# Merge
iasl -da -dl -fe refs.txt DSDT.aml SSDT*.aml

# Install MaciASL
if [ ! -d /Applications/MaciASL.app ]; then
  sudo spctl --master-disable;
  cp -R  ~/Desktop/Guide-ROG/software/MaciASL.app /Applications/MaciASL.app;
fi

# Done
printf "\n\n\n          DONE\n------------------------\n\n\n";

# Open Origin folder
open -a Finder ~/Desktop/origin/DSDT.dsl
