#!/bin/bash

CURRENTDATE=`date +"%Y-%m-%d__%H_%M_%S__$RANDOM"`;

# Go to origin folder
cd ~/Desktop/origin;

# Save patched folder
if [ -f /Volumes/EFI/EFI/CLOVER/ACPI/patched ]; then
	mkdir -p ~/Desktop/origin-backups;
	mv -v /Volumes/EFI/EFI/CLOVER/ACPI/patched ~/Desktop/origin-backups/patched_$CURRENTDATE;
fi

# Remove old patched folder
rm -fr /Volumes/EFI/EFI/CLOVER/ACPI/patched
# Create new patched folder
mkdir -p /Volumes/EFI/EFI/CLOVER/ACPI/patched;

# Copy .aml files
find -E . -type f -regex "^./.*.aml" -exec cp {} /Volumes/EFI/EFI/CLOVER/ACPI/patched \;

# Done
printf "\n\n\n          DONE\n------------------------\n\n\n";
