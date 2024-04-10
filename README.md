# Summary
1. Open the terminal
1. Set keyboard localization
1. Get root access
1. Set language
1. Enabling internet
1. 내나라 (NèNala/My Country) in english
1. Removing the antivirus & spyware
1. Enabling sudo
1. Installing additional official packages
1. Enabling other repositories
1. Downloading RPM by hands
1. Updating kernel
1. Installing another old version of Firefox
1. Edit your user icon
1. Softwares
	- File Manager
	- NaeNara
	- Software Manager
	- Sogwang Office
	- Trash
	- GIMP
	- UnBangUI
## Open the terminal
1. Click on the Application folder on the right of the Dock (aside of the bin) «응용프로그람».
1. Click on the folder without any icon ("AppLink", or «고전형프로그람»).
1. Click on the folder with a hammer and a wrench («보조프로그람»).
1. Click on the Terminal. ("Konsole", or «조작탁»).
## Set keyboard localization
1. Launch the app called "System Settings", or «체계환경설정».
1. Click on "International", or «다국어» (should be on the upper-left).
1. Click on the second tab: "keyboard localiazation", or «다국어입력».
1. Click on the localization you want.
WARNING: there might be inconsistencies, and the localization might not exactly follow yours.

## Get root access
1. Open a terminal
1. Run ``rootsetting``
1. Click on the lock, enter your credidentials
1. Click on the checkbox.

## Set language
1. Open the terminal
1. Switch to root (`su` command).
1. Run the following command:
```bash
sed -i 's/ko_KP/en_US/g' /etc/sysconfig/i18n /usr/share/config/kdeglobals && reboot
```
**WARNING:** The system will not be compatible with any other language.
## Enabling internet
By default, RedStar is configured to take advantage of DPRK's intranet «광명».
Since we have no access whatsoever to it, let's allow the use of regular internet:
1. Open the terminal
1. Switch to root (`su` command).
1. Run the following commands:
```bash
rm /etc/sysconfig/iptables && service iptables restart
```
**WARNING:** HTTPS and SSL won't work. While you *can* access websites such as [Google](http://google.com),
most websites won't work.

## 내나라 (NèNala/My Country) in english
내나라 is the default (and only) web browser. It is a modified version of Firefox 3.5/3.6.
However, it has a few additions, such as an extensions to edit its language.
To disable it, follow these instructions:
1. Open «내나라» (the Earth icon).
1. Click on «도구» (second menu from the right, on the bar at the top).
1. Click on «부가기능» (third option).
1. In the window that just opened, click on 언어 (second tab from the right).
1. Press the button under the only language pack («사용합»).
1. A yellow warning should tell you that you will need to reboot in korean. Press the button.
You're done.

## Removing the antivirus & spyware
1. Download on another computer the code [here](https://github.com/takeshixx/redstar-tools/tree/master) (Code 
button, "Download ZIP" if you don't know how to use git).
1. Bring the files to RedStar, and open a terminal.
1. Switch to root (`su` command).
1. Run the following commands (remember to replace your_folder by the actual folder used to store these):
```bash
chmod +x your_folder/defuse.sh
your_folder/defuse.sh
```

## Enabling sudo
Run as root 
```sh
usermod -aG wheel [username]
```

## Installing additional official packages
Mount the installation media, and open "Software Manager" or «프로그람 ... 밎 삭제». It should prompt you the location of the media
(most likely `/media/[media-name]`), click on it.
Then, you'll have a long list of apps you can add such
as games, Flash Player, or even a programming IDE.
Just check what you want ot install. You can uncheck
something to uninstall it.

## Enabling other repositories
## Downloading RPM by hands
Go and download what you need there. Fedora 8 is used as RedStar is quite old.
Dependencies might not be there.

[Download RPMs, Fedora 8 i386](http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/8/Everything/i386/os/Packages/)
## Updating the kernel
Make a backup of the system as it may not boot if you fail these steps.

Download a more recent version of the kernel. I used the [4.9.90-040990-generic](https://kernel.ubuntu.com/mainline/v4.9.90/linux-image-4.9.90-040990-generic_4.9.90-040990.201803250830_amd64.deb). You may choose another, but I decided to go with this one.

**REMEMBER IT HAS TO SUPPORT EXT3**
[Click here to find all kernels](https://kernel.ubuntu.com/mainline/)

Extract the contents on your main machine (I don't think you can directly do it on 붉은별...).
Now, using root, copy all folders to the root of your machine. (/linux-image-.../usr -> /usr, ect).

Once that's done, run the following commands as root:
```sh
depmod -a <kernel-version>
dracut -f /boot/initramfs-<kernel-version>.img <kernel-version>
# The command I ran with the version I chose:
depmod -a 4.9.90-040990-generic
dracut -f /boot/initramfs-4.9.90-040990-generic.img 4.9.90-040990-generic
```
It might take a while, because it's essentially regenerating the initial ram file to boot.

Once it's done, go edit the `/boot/grub/grub.conf` file.
Replace the `kernel` parameter with the location of the `vmlinuz` file. (It should be in `/boot/`).

Replace the initrd parameter with the location of the `initramfs` file we generated earlier (It should also be in `/boot`).

Now, simply reboot (using the `reboot` command for instance).

## Installing another old version of Firefox
I could only launch up to [Firefox 9.0](https://ftp.mozilla.org/pub/firefox/releases/9.0/linux-i686/)
(although, lowest I tested above 9.0 was 29.0), because
other version would give me a GTK error, or a XPCOM loading failure error for 20 and above.

I went on the [official Mozilla public repository](https://ftp.mozilla.org/pub/firefox/releases/), chose the Firefox version, and chose `linux-i686`.
I then extracted it and directly launched the executable.

**WARNING: Putting it in /usr/bin WILL erase 내나라!**

Firefox 9.0 has (mostly) proper SSL certificates, and it supports HTTPS. It sure is a more pleasant
use of the internet than the outdated 내나라.

## Edit your user icon
Replace the file at `~/.[username].ico` by your new icon.
It can be a PNG file.

## Softwares
### File Manager - KFinder
KFinder, like all other apps, is a KDE software. It's not dolphin, though,
it's actually **konqueror**. Since some files are hidden in the file manager,
you can directly go to them by entering in the terminal:
```bash
konqueror your_folder
```

Just so you know the folders at the root folder:
```
a
Applications
.autofsck
.autorelabel
bin
boot
dev
etc
home -> /Users
lib
lost+found
media
mnt
opt
proc
root
sbin
selinux
srv
sys
System
tmp
Users
usr
var
```

### 내나라 (My Country/Nènala) - Web Browser
In DPRK, the intranet 광명 is used instead of the internet. Apparently, most web browsers used in DPRK does not
accept non-ASCII characters as a URL (such as korean characters), and as schools don't teach people how to
transcribe korean into latin characters, there is a preference for raw IP adresses.
The default address is : http://10.76.1.11/naenarabrowser/

The web browser is based on Firefox 3.5. SSL and HTTPS will not work, though.

### Software Manager
The Software Manager is an app that allows to install or remove programs from a local
or distant repository. Basically an interface for `yum`.
I don't encourage using the public websites from there as there might be versions mismatches.

What I do recommand is plugging in the RedStar installation media, and installing what is proposed on the disk.
You may see a lot of stuff such as development IDE, or compilers like GCC.

### 서광사무처리 - Sogwang Office
Based on OpenOffice 3.0, the icons are from Microsoft Office 2003.
This is the best place to notice the fonts "KP ...". These are standard DPRK fonts used everywhere.

### Trash
Trash location is `~/.local/share/Trash/files/`.
I haven't looked around enough to find a way to
permanently empty it through the GUI so I just run
```sh
rm ~/local/share/Trash/files/* -rf
```
as a normal user.

### 화상 - GIMP
**This is an additional program.**
It's a recompiled version of GIMP 2.4.

Note that the program's english version is still present.

### CD/DVD Writer
It's another KDE app, K3B.

### 은방의 - UnBangUI
It's a music score composer app. While I couldn't find its
exact origins, I think it is a port of MuseScore 1, although
the english translation is nowhere to be seen.
There are sample songs, none of which are korean songs.

If I say it looks like MuseScore 1, it's because of the similar UI,
and functionalities, though I don't remember MuseScore ever
using the SM2 format, which I know very little about.

The default soundfont seems to be the same one used by Android 5.



# Credit
- [@cursedastronaut](https://github.com/cursedastronaut/) for everything you haven't seen elsewhere.
- [RichardG's Rambling](https://richardg867.wordpress.com/) for his two articles guiding beginners through the operating system
	1.	[Article 1](https://richardg867.wordpress.com/2015/01/01/notes-on-red-star-os-3-0/)
	2.	[Article 2](https://richardg867.wordpress.com/2020/03/31/more-notes-on-red-star-os-3-0/)
- [@takeshixx](https://github.com/takeshixx/) for the [redstar-tools](https://github.com/takeshixx/redstar-tools/tree/master).
- [@cylian914](https://github.com/cylian914) for the kernel update idea. 