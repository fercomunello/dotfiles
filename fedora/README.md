# Fedora Workstation

## Install Fedora
**Download the ISO image:** https://fedoraproject.org/workstation/download

For that I configure a bootable USB device using [Ventoy](https://www.ventoy.net/en/download.html) so
we don't need to format the disk over and over again, we just need to copy the ISO file to the USB drive and boot them directly.

On the installation process I generally do partitioning manually because I also have Windows installed in another partition so
I simply create a /boot/efi partition with 512M for Linux and a root (/) partition - by default Fedora adds [ZRAM swap](https://docs.fedoraproject.org/en-US/fedora-coreos/sysconfig-configure-swaponzram/).

## After installation
### Install media codecs
Since last versions of Fedora, some media codecs are not built-in with the distro anymore so we need to install it manually:
https://docs.fedoraproject.org/en-US/quick-docs/installing-plugins-for-playing-movies-and-music

```bash
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ; \
sudo dnf install -y lame\* --exclude=lame-devel ; \
sudo dnf group upgrade -y --with-optional Multimedia ; \
sudo dnf install -y libavcodec-freeworld mesa-va-drivers-freeworld ; \
sudo dnf install -y mpv
```

Then update and reboot the machine. To test codecs later, play some YouTube videos to make shure.
```bash
sudo dnf update -y && systemctl reboot -i
```

### Install Spotify
Because we would like to listen some heavy-metal songs while setting up our Fedora \m/ <br>
https://docs.fedoraproject.org/en-US/quick-docs/installing-spotify

I prefer to install that kind of application with Flatpaks:
```bash
sudo dnf install -y flatpak ; \
flatpak remote-add --if-not-exists flathub ; \
https://flathub.org/repo/flathub.flatpakrepo ; \
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Now it's easy:
```bash
flatpak install -y flathub com.spotify.Client
```

