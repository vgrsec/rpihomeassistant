# Home Automation Fun

## Steps - Docker

1. Flash rasbian os 32bit onto SD card
1. modify /mnt/config.txt
1. Add the following parameters to the bottom of the /boot/config.txt file.
https://www.home-assistant.io/docs/z-wave/controllers/
```
# Enable zwave.me and disable onboard bluetooth
dtoverlay=disable-bt
enable_uart=1
```
1. `sudo apt-get install git`
1. git clone https://github.com/vgrsec/rpihomeassistant.git
https://jugmac00.github.io/blog/how-to-run-a-dockerized-service-via-systemd/


## Steps

1. Flash haos_rpi4 onto SD card
1. Install SD card into rpi 4
1. Boot Rpi 4
1. Create a user account and log into Home Assistant Web Interface `http://haos.local:8123`
1. Enable Advanced Settings in User Profile `http://haos.local:8123/profile`
1. Install, and Start SSH Module `http://haos.local:8123/hassio/dashboard`
1. Generate ssh public key pair on laptop
```
ssh-keygen -t rsa -f ~/.ssh/haos_debug -b 2048 -q -N ""
```
1. Create USB drive named `CONFIG` formatted FAT32 on laptop
1. Copy public key to USB drive and rename the public key to `authorized_keys` on Laptop
1. Move USB drive to Rpi 4
1. Open SSH Web Terminal in Home Assistant Web Interface `http://haos.local:8123/core_ssh/dashboard`
1. Run command `ha os configure` 
1. On Laptop run `ssh -i ~/.ssh/haos_debug root@haos.local -p 22222`
1. Modify boot settings for Razberry Board
```
login
mount /dev/disk/by-label/hassos-boot /mnt/
cd /mnt/
vi config.txt
```
1. Add the following parameters to the bottom of the /boot/config.txt file.
```
dtoverlay=disable-bt
enable_uart=1
```
1. Exit vi and unmount boot
```
cd ..
umount /mnt
```

1. Restart using Home Assistant Web Interface `http://haos.local:8123/config/hardware`
1. Log into Home Assistant on reboot `http://haos.local:8123`
1. Once logged in, shut down using Home Assistant Web Interface `http://haos.local:8123/config/hardware`
1. Install Razberry board 
1. Boot HAOS
1. Install and start z-wave.js `http://haos.local:8123/hassio/dashboard`
1. Add zwave integration `http://192.168.0.11:8123/config/integrations`

## Adding Pictures

Make a www directory to host files on homeassistant 
* mkdir /mnt/data/supervisor/homeassistant/www/

Create a symlink between a media folder on your webserver and the default home assistant media upload folder 
* ln -sf /mnt/data/supervisor/homeassistant/www/media/ /mnt/data/supervisor/media

Now the photos you upload will be available 
http://192.168.0.11:8123/local/media/backporch.png

## Resources

* https://community.home-assistant.io/t/how-to-mount-access-hassos-boot-partition/257587/2

https://www.home-assistant.io/docs/z-wave/controllers/#supported-z-wave-usb-sticks--hardware-modules

https://developers.home-assistant.io/docs/operating-system/debugging/

https://z-wave.me/support/zmeserialupdater-manual/