# WARNING! DO NOT TRY THIS SCRIPT YET.

#!/bin/bash
VERSION="4.9.90-040990-generic"
# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root."
	echo "Use the command [38;2;102;89;92mrootsetting[0m to get root access."
	exit 1
fi

# Warning part
ecjp "@cursedastronaut on GitHub"
echo "This script MUST ONLY BE RAN ON [91mRedStar OS 3.0[0m"
echo "I am NOT responsible anything this script can directly or indirectly cause"
echo "The script will do the following:"
echo "	- Enable internet access"
echo "	- Set the system language to english"
echo "	- Set Sogwang Office language to english"
echo "	- Remove the antivirus, and spywares"
echo "	- Updating the kernel to $VERSION"
echo "	- Reboot"
echo "Do you agree? (Y/n)"
read -r confirmation

# Check if the user agrees
if [ "$confirmation" != "Y" ]; then
	echo "You declined to proceed."
	exit 1
fi

#Enable the exit on error option
set -e

# Enable internet access
echo "Enabling internet access..."
rm /etc/sysconfig/iptables && service iptables restart

# Set language to english
echo "Setting language to english..."
sed -i 's/ko_KP/en_US/g' /etc/sysconfig/i18n /usr/share/config/kdeglobals
echo "Setting Sogwang office language to english..."
rm /Applications/SGOffice.app/Contents/RedStar/resources/*ko.res
rm /Applications/SGOffice.app/Contents/share/registry/Langpack-ko.xcd

if [ -e redstar-tools-master.zip ]; then
	# Unzip redstar-tools-master
	unzip redstar-tools-master.zip
	chmod +x redstar-tools-master/defuse.sh
	redstar-tools-master/defuse.sh
else
	echo "Red Star tools can't be found ([38;2;102;89;92mredstar-tools-master.zip[0m)"
	echo "Cannot remove spywares and antivirus."
fi

if [ -e redstar-tools-master.zip ]; then
	unzip "$VERSION".zip
	cp boot/* /boot/ -r
	cp usr/* /usr/ -r
	cp lib/* /lib/ -r
	depmod -a $VERSION
	dracut -f /boot/initramfs-$VERSION.img $VERSION

	# Get the last kernel version from the file name
	last_kernel=$(ls -v /boot/vmlinuz-* | tail -n1)

	# Escape special characters in the last kernel version
	escaped_last_kernel=$(printf '%s\n' "$last_kernel" | sed 's/[\&/]/\\&/g')

	# Perform the replacement using sed
	sed -i "s@/boot/vmlinuz-2.6@${escaped_last_kernel}@" /boot/grub/grub.conf

else
	echo "Kernel can't be found ([38;2;102;89;92m$VERSION.zip[0m)"
	echo "Cannot update kernel."
fi

echo "The system will reboot in 5 seconds."
sleep 5
reboot