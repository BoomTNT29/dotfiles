# My Arch Linux Set Up

## Installation

Create a free partition that we will be using to run linux on, this partition will include the boot, root directory and swap.

Install the latest arch linux build from an official arch mirror and use `Rufus` to burn on an USB stick.

Launch the UEFI Firmware:
    - Turn `Secure Boot` off.
    - Set the boot option to boot from the USB stick.

After booting up, select the `Arch Installation Medium`.

After it finishes booting up, connect to wifi using `iwctl`. Here are the basic commands that we will be using:
    - `device list` to list the devices
    - `station <insert station here> get-networks` to list all the networks.
    - `station <insert station here> connect <wifi network>` to connect to the network. (Incase of college wifi some extra steps might be required)
    - `exit` to exit.

Sync the pacman database: `pacman -Sy`.
Also install the archlinux-keyring package: `pacman -Sy archlinux-keyring`.

Use `lsblk` to list all the drives and their partitions.

Now type `cfdisk /dev/<disk>` to open diskmgmt.
    - Scroll to the free space. We need to create 3 partitions: boot, root and swap.
    - The boot partition will of type `EFI System`, keep it to 800MB that will be sufficient.
    - The root partition will of type `Linux File System`.
    - The swap partition will of type `Swap`.

We now need to format these partitions:
    - `mkfs.fat -F32 /dev/<partition>` for the boot partition.
    - `mkfs.ext4 /dev/<parition>` for the root partition.
    - `mkswap /dev/<partition>` for the swap partition.

Now go ahead and mount these partitions:
    - `mount /dev/<root partition> /mnt` to mount the root partition.
    - Now create a boot directory in `/mnt` and mount the root partition, `mount /dev/<boot parition> /mnt/boot`.
    - Enable swap using `swapon /dev/<swap parition>`.

Now its time to install linux to the root parition that is mounted on the `/mnt` using this command:
`pacstrap -i /mnt base base-devel linux linux-firmware git sudo neofetch htop amdm-ucode nano vim bluez bluez-utils networkmanager`

Now its time to generate a fstab (file system table). All the partitions are mounted on the live session of USB, but when we boot arch from the partition we need to tell the system to mount all these partitions from the same location:
`genfsatb -u /mnt >> /mnt/etc/fstab`

Now its time to chroot into our `/mnt`: `arch-chroot /mnt`

First type `passwd` and set the password.
Create a standare user using this command: `useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash <username>`
Then set the password: `passwd <username>`

Now we need to let the wheel group users to use `sudo` commands. For that we need to edit the `visudo` file: `EDITOR=nano visudo`


In this file, uncomment the part that says to allow members of group wheel to execute any command.

You can check if this has worked by switching accounts (`su <username>`) and run a system update.

Now set the timezone using `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime` and then `hwclock --systohc`.

Now set a system language by generating a locale: `nano /etc/locale.gen`, and uncomment the UTF-8 one.

Then type `locale-gen` and generate a locale.

Now create a locale config file by typing `nano /etc/locale.conf` and type `LANG=en_US.UTF-8`.

Now its time to setup a hostname for the computer:

`nano /etc/hostname` and write your desired hostname.

Then type: `nano /etc/hosts` and type the following:

```
127.0.0.1   localhost
::1         localhost
127.0.1.1   <hostname>.localdomain      <hostname>
```

Now its time to install the grub bootloader: `pacman -S grub efibootmgr dosfstools mtools`

Now type: `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`

then: `grub-mkconfig -o /boot/grub/grub.cfg`

Now enable the bluetooth service and NetworkManager service:

`systemctl enable bluetooth`
`systemctl enable NetworkManager`

Finally, `exit` from the chroot environment and type: `umount -lR /mnt` to unmount `/mnt`.

And then, `shutdown now` the system, and unplug the USB pendrive.

Now turn on the system back again, boot into arch for now, we'll fix the windows issue not coming up later.

Login to your user account.

We will use `nmcli` to connect to wifi:
    - `nmcli dev status` to see your networking devices.
    - `nmcli radio wifi on` to turn on wifi.
    - `nmcli dev wifi list` to see the list of networks.
    - `sudo nmcli dev wifi connect <SSID> password <PASSWD>`
    - `ping google.com` to check.

Update the full system: `sudo pacman -Syu`

### Installing the Desktop Environment

We are installing `plasma KDE`:

`sudo pacman -S xorg sddm plasma-meta plasma-meta kde-applications dolphin konsole kwrite libreoffice-fresh firefox cargo clang cmake make gcc noto-fonts noto-fonts-emoji ttf-dejavu ttf-font-awesome`

`sudo systemctl enable sddm`

`sudo systemctl start sddm`

Now reboot the system to restart all the services, and now arch linux will start with `plasma-KDE`.

Now we need to fix the discover app error, to do so we need to install flatpak: `sudo pacman -S flatpak`

## Installing NVIDIA Drivers

`sudo pacman -Sy nvidia`

And then reboot.

Type: `nvidia-smi`

## Adding Windows Entry to the Grub Bootloader

First install `os-prober`: `sudo pacman -S os-prober`

Then edit the grub-configuration file, `sudo nano /etc/default/grub`:
    - change the default TIMEOUT to 20 seconds
    - uncomment the last line (GRUB_DISABLE_OS_PROBER)
    - save changes

Now mount the windows `efi` partition and run this command: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

Now if you reboot your system, you will see the option for windows 11 too.

# How to delete the partitions

You can delete the root and swap partitions directly from `diskmgmt`, but to delete the efi partition we need to take a few extra steps.

Open `cmd` in administrator mode.
    - type `diskpart`
    - type `list disk` to list all the disks
    - type `select disk <number>`
    - `list partition` to list all the partitions
    - `select partition <number>`
    - `delete partition override` NOTE: THIS IS A DESTRUCTIVE OPERATION

# Enabling Secure-Boot

Enter set-up mode, this is done by resetting all the keys related to secure boot.
Then install `sbctl` and reinstall grub with `tpm` module:
    - `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --modules="tpm" --disable-shim-lock`
    - `sudo pacman -S sbctl`

Type `sbctl status` to see general status.
Create your own custom secure boot keys using: `sbctl create-keys`
Enroll those keys with Microsoft's keys: `sbctl enroll-keys -m`
Type `sbctl status` again to verify that the above steps were successful.
Type `sbctl verify` to see what files need signing, the type `sbctl sign -s /path/to/file` for all those files.

Reboot and enjoy!
