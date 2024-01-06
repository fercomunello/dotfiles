# Fedora Workstation

## Install Fedora
**Download the ISO image:** https://fedoraproject.org/workstation/download

For that I configure a bootable USB device using [Ventoy](https://www.ventoy.net/en/download.html) so
we don't need to format the disk over and over again, we just need to copy the ISO file to the USB drive and boot them directly.

On the installation process I generally do partitioning manually because I also have Windows installed in another partition so
I simply create a /boot/efi partition with 512M for Linux and a root (/) partition - by default Fedora adds [ZRAM swap](https://docs.fedoraproject.org/en-US/fedora-coreos/sysconfig-configure-swaponzram/).

## After installation

I keep Wayland display server selected on GDM as it's more smoother than Xorg (X11) and more secure. But if you doesn't have a AMD GPU but a NVIDA one, better stick with Xorg for now.

**Xorg note:** For multi-monitor setups with different refresh rates i.e. 144hz and 60hz, this configuration must be added on startup to avoid screen tearing and lag issues (play with these [config options](https://wiki.archlinux.org/title/AMDGPU#Xorg_configuration) as needed:
sudo touch /etc/X11/xorg.conf.d/20-amdgpu.conf
```bash
cat << EOF | sudo tee -a /etc/X11/xorg.conf.d/20-amdgpu.conf
Section "Device"
     Identifier "AMD"
     Driver "amdgpu"
     Option "TearFree" "true"
     Option "VariableRefresh" "true"
EndSection
EOF
```

### Enable RPMFusion repositories
To enable access to both the free and the nonfree repository use the following command:
```bash
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Install media codecs and MPV
Since last versions of Fedora, some media codecs are not built-in with the distro anymore so we need to install it manually:
https://docs.fedoraproject.org/en-US/quick-docs/installing-plugins-for-playing-movies-and-music

```bash
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel && \
sudo dnf install -y lame\* --exclude=lame-devel && \
sudo dnf group upgrade -y --with-optional Multimedia ; \
sudo dnf install -y mpv 
```

### Switch to full ffmpeg and install additional codecs
Fedora ffmpeg-free works most of the time, but one will experience version missmatch from time to time. Switch to the rpmfusion provided ffmpeg build that is better supported.
```bash
sudo dnf swap ffmpeg-free ffmpeg --allowerasing ; \
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && \
sudo dnf groupupdate -y sound-and-video
```

### Enable AMD GPU hardware codecs
**Mesa-based drivers:** These drivers contains video acceleration codecs for decoding/encoding H.264 and H.265 algorithms
and decoding only VC1 algorithm. Add support for both hardware APIs: VA-API and VD-PAU.

```bash
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld ; \
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
```

### Reboot
Then update and reboot the machine.
```bash
sudo dnf update -y && systemctl reboot -i
```

To test codecs later, play some [1080p](https://youtu.be/yKELA1qBAKA) and [4K](https://youtu.be/euPjji8fIGg) YouTube videos to make shure.

To check if VA-API hardware API is working:
```bash
sudo dnf install libva-utils -y && vainfo && sudo dnf remove libva-utils -y
```

### Install AMD ROCm OpenCL
Theses additional packages are required for Davinci Resolve and other GPU accelerated softwares.

For more information, see: https://fedoraproject.org/wiki/SIGs
```bash
sudo usermod -a -G video $LOGNAME && sudo dnf install rocm-opencl
```

### Install Spotify
Because we would like to listen some metal songs while setting up our Fedora \m/ <br>
https://docs.fedoraproject.org/en-US/quick-docs/installing-spotify

I prefer to install that kind of application with Flatpaks:
```bash
sudo dnf install -y flatpak ; \
flatpak remote-add --if-not-exists flathub ; \
https://flathub.org/repo/flathub.flatpakrepo ; \
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Now it's easy, install via GNOME software or run this command:
```bash
flatpak install -y flathub com.spotify.Client
```

### Disable Hibernation
```bash
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0 ; \
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0 ; \
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false ; \
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
```

On GNOME Settings, set Power > Screen Blank to "Never", Automatic Suspend to "Off", Power Behaviour Button to "Power Off" and Power Mode to "Performance".

Also, to prevent screen to go off when it's on GDM (login manager) with the desktop locked, install the [Unblank Extension](https://github.com/sunwxg/gnome-shell-extension-unblank).

### Disable Mod+P global shortcut
Mod+P is a global default shortcut that switch monitor to Join or Mirror mode. If we disable it, we can assign our custom keybinding to Mod+P later.
```bash
gsettings set org.gnome.mutter.keybindings switch-monitor "[]"
```

### Configure Keyboard
* Configure keyboard delay repeat rate:
Settings > Accessibility > Typing > Typing Assist > Repeat Keys
- Speed default or decrease a little bit.
- Delay a little greater than "Short".

### Remap CapsLock to ESC
I usually remap CAPS to ESC to exit Vim insert mode. To do that in a lower levelwith maximum priority, follow this steps:

* Install evtest to get key codes of your keyboard device.
```bash
sudo dnf install -y evtest
sudo evtest
```

The output will be something like:
```plain
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x1532 product 0x227 version 0x111
Input device name: "Razer Razer Huntsman"
 # /dev/input/event3:	Razer Razer Huntsman
 # Select the device event number [0-26]:  3

Event: time 1692498221.449233, -------------- SYN_REPORT ------------
Event: time 1692498223.002147, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70039
Event: time 1692498223.002147, type 1 (EV_KEY), code 58 (KEY_CAPSLOCK), value 1
```

* To configure the remap permanently:
```bash
sudo vi /etc/udev/hwdb.d/50-keys_remap.hwdb
```

Sample: must change bus, vendor, product and version information.
```
# evdev:input:b<bus_id>v<vendor_id>p<product_id>e<version_id>-<modalias>
# bus 0x3 vendor 0x1532 product 0x227 version 0x111
evdev:input:b0003v1532p0227*
  KEYBOARD_KEY_70039=esc

# replace /dev/input/event3 by the device input event number, it should display
"E: KEYBOARD_KEY_70039=esc"
```
* Now it's configured, the evtest utility package can be removed.
```bash
sudo dnf remove -y evtest
```

### Configure Keyboard Shortcuts

**System:**
 **Lock screen**: Mod+Alt+Del <br>
 **Log out**: Mod+Alt+Shift+Del <br>
 **Show all apps**: Mod+A <br>
 **Show notifications**: Disabled <br>
 **Focus the active notification**: Mod+N <br>
 **Show the overview:** Mod+Space <br>
 **Show all apps:** Mod+A <br>
 **Restore the keyboard shortcuts:** Disabled <br>
 **Show the notification list:** Mod+V <br>

**Navigation:**
  **Move to workspace on the left:** Mod +H <br>
  **Move to workspace on the right:** Mod+L <br>

  **Move window one workspace to the left:** Mod+Shift+H <br>
  **Move window one workspace to the right:** Mod+Shift+L <br>
  **Mode window to last workspace:** Mod+Shift+0 (keypad) <br>

  **Mode window one monitor to the left:** Mod+Ctrl+Shift+H <br>
  **Mode window one monitor to the right:** Mod+Ctrl+Shift+L <br>
  **Mode window to workspace 1:** Mod+Shift+1 <br>
  **Mode window to workspace 2:** Mod+Shift+2 <br>
  **Mode window to workspace 3:** Mod+Shift+3 <br>
  **Mode window to workspace 4:** Mod+Shift+4 <br>
  **Switch system controls directly:** Disabled <br>
  **Switch applications:** Alt+Tab <br>
  **Switch to last workspace:** Mod+0 (keypad) <br>
  **Switch windows:** Mod+Tab <br>

  * **Note:** It's also possible to move between workspaces by holding 
  Mod key while scroll up and down.

**Windows:**
  **Close window:** Mod+Q <br>
  **Toggle fullscreen mode:** Mod+F <br>
  **Resize window:** Mod+R + arrow keys <br>
  **Move window:** Mod+W + arrow keys <br>
  **Maximize window:** Mod+Ctrl+K <br>
  **Restore window:** Mod+Ctrl+J <br>
  **View split on left:** Mod+Ctrl+H <br>
  **View split on right:** Mod+Ctrl+L <br>
  **Maximize window horizontally:** Mod+Ctrl+Shift+K <br>
  **Maximize window vertically:** Mod+Ctrl+Shift+J <br>
  **Activate the window menu:** Mod+Space <br>
  **Toggle window on all workspaces or one:** Mod+Shift+Ctrl+A <br>
  **Hide all normal windows:** Mod+\ <br>

**Launchers:**
  **Home folder:** Mod+E <br>
  **Calculator:** Mod+C <br>
  **GNOME Help:** Mod+F1 <br>
  **Web Browser:** Mod+B <br>
  **Settings:** Mod+,(keypad) <br>

**Custom Shortcuts:**
**Launch Alacritty Terminal:** Mod+Return/enter <br>
  -> env -u WAYLAND_DISPLAY alacritty <br>  
**Open Vim:** Mod+T <br>
  -> env -u WAYLAND_DISPLAY alacritty --command vim <br>
**Launch Text Editor:** Mod+F8 <br>
  -> gnome-text-editor --new-window --ignore-session <br>
**Launch Spotiy:** Mod+F5 <br>
  -> flatpak run com.spotify.Client <br>
**Launch Firefox:** Mod+F6 <br>
  -> firefox <br>
**Launch Dialect (for text translation):** Mod+D <br>
  -> dialect <br>
	
**Sound and Media:**

  **Volume up:** Mod+Alt + = <br>
  **Volume down:** Mod+Alt + - <br>
  **Play/pause:** Mod+Alt+P <br>
  **Volume mute/unmute:** Mod+Alt+9 <br>
  **Microphone mute/unmute:** Mod+Alt+0 <br>

**Screenshots:**
  **Take a screenshot interactively:** Print <br>
  **Take a screenshot of a window:** Mod+Print <br>
  **Take a screenshot:** Shift+Print <br>
  **Record a screencast interactively:** Shift+Ctrl+Alt+R <br>

**Accessibility:**
  **Turn zoom on or off:** Mod+Shift+Z <br>
    **Zoom in:** Mod+Shift+= <br>
    **Zoom out:** Mod+Shift+- <br>
  **Increase text size (scale factor):** Mod+F12 <br>
  **Decrease text size (scale factor):** Mod+F11 <br>

**Typing:**
  **Switch to next input source:** Disabled <br>
  **Switch to previous input source:** Disabled <br>
  **Restore keyboard shortcuts:** Disabled <br>

### Configure Dconf-editor
A graphical tool for editing the dconf database.

```bash
sudo dnf install -y dconf-editor
```

**Disable Mod key when pressed alone:** `org > gnome > mutter -> overlay-key`, because Mod+Space is been used to open GNOME overview instead,
that way we avoid accidentally opening the overview. <br>

### Enhancing the workflow with extensions

First, install GNOME Extensions extension on the browser and also on the system `sudo dnf install -y gnome-extensions-app`.

* [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/):
Tweak Tool to customize GNOME Shell.

Visibility options that I disabled:
- Window Picker Caption (the text under window preview in overview).
- Workspace Popup (popup that appears on the screen when you switch to other workspace).
- Dash and Dash separator (the pinned apps in the overview).
- Activities button (actually replaced with Logo Menu extension).

Shortcuts:
- **Alt+Esc (capslock):** Switch to previous workspace<br>
- **Mod+1..n:** Switch to workspace n<br>
- **CTRL+Alt+Mod+H:** Move current workspace left<br>
- **CTRL+Alt+Mod+L:** Move current workspace right<br>


* [Vim Alt Tab](https://github.com/koko-ng/vim-altTab):
Switch between windows on Alt|Mod+Tab using Vim keys: H,J,K,L.

* [Focus Follows Workspace](https://extensions.gnome.org/extension/4688/focus-follows-workspace):
Focus the primary monitor after switching workspaces via keyboard

* [Space Bar](https://extensions.gnome.org/extension/5090/space-bar):
Replaces the activities button with an i3-like workspaces bar (not needed for GNOME 45+ anymore).

* [Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar):
Hides the top bar, except in overview (not available for GNOME 45+ yet).

* [No Titlebar When Maximized](https://extensions.gnome.org/extension/4630/no-titlebar-when-maximized):
Hides the classic title bar of maximized x.org windows (not needed for GNOME 45+).

* [Just Perfection](https://extensions.gnome.org/extension/3843/just-perfection/):
Tweak Tool to customize GNOME Shell.

* [Blur My Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/):
Adds a blur look to different parts of the GNOME Shell.

* [Logo Menu](https://extensions.gnome.org/extension/4451/logo-menu/):
Replace the Activies with a menu logo.

* [Spotify Tray](https://extensions.gnome.org/extension/4472/spotify-tray/):
Adds a button to the panel that shows info and spotify playback.

* [Window/app switcher on active monitor](https://extensions.gnome.org/extension/5568/monitor-window-switcher-2):
GNOME Shell extension that puts the window switcher accordingly to the active monitor/workspace (not available for GNOME 45+ yet).

* [Focus Changer](https://extensions.gnome.org/extension/4627/focus-changer):
Change focus between windows in all directions.


Shortcuts:
- **Focus up:** Mod+Alt+K <br>
- **Focus down:** Mod+Alt+J <br>
- **Focus left:** Mod+Alt+H <br>
- **Focus right:** Mod+Alt+L <br>

* [Awesome Tiles](https://extensions.gnome.org/extension/4702/awesome-tiles):
Tile windows using keyboard shortcuts.

Awesome Tiles shortcuts:
- **Enable window animation:** Disabled <br>
- **Gap Between Window and Workspace:** 1 <br>
- **Gap Size Increments:** 4 <br>
- **Gaps Between Windows:** Enabled <br>
- **Align Window to Center:** Mod+0 <br>
- **Increase the Gap Size:** Mod+= <br>
- **Decrease the Gap Size:** Mod+- <br>
- **Tile Window to Center:** Mod+~ <br>
- **Tile Window to Left:** Mod+Ç <br>
- **Tile Window to Right:** Mod+] <br>
- **Tile Window to Top:** Mod+' <br>
- **Tile Window to Top Left:** Mod+P <br>
- **Tile Window to Bottom Left:** Mod+, <br>
- **Tile Window to Bottom Right:** Mod+; <br>



### Improve font rendering
Well, the default fonts on major distros are not so polished like macOS and not so legible as Microsoft Windows fonts. To completely resolve this issue we need to change the fonts at system level.

To install Microsoft official fonts there is two methods:
1) If you have a dual boot setup with Windows 10/11, just mount the partition where WIndows is installed and copy the fonts to Linux.
2) If you want to download the fonts, [check this](https://wiki.archlinux.org/title/Microsoft_fonts) for more info.

For the first method:
Mount the Windows partition using Nautilus via GUI or do manually:
```bash
# This package is included by default on Fedora
sudo dnf install -y ntfs-3g
# Get devices information
lsblk
#Mount manually
sudo mount --mkdir /dev/sda3 /mnt/windows

# mount after copying font files..
#sudo umount /dev/sda3 && sudo rm -rf /mnt/windows
```

If the partition was mounted with Nautilus, the mounted folder will have a sort of ID like /run/media/fernando/0AE62F3FE62F2A81.

Now copy Microsoft fonts from Windows:
```bash
sudo cp /run/media/fernando/0AE62F3FE62F2A81/Windows/Fonts/* /usr/local/share/fonts/WindowsFonts/ ; \
sudo chmod 644 /usr/local/share/fonts/WindowsFonts/*
```

Also, you may want to install Apple fonts.
```bash
cd /tmp && git clone https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts.git && \
sudo mkdir -p /usr/local/share/fonts/AppleFonts && \
sudo cp *.ttf *.otf /usr/local/share/fonts/AppleFonts && cd -
```

For Alacritty and IDEs, the JetBrains Mono fonts are very good, just install directly via Fedora's repositories.
```bash
sudo dnf install -y jetbrains-mono-fonts-all
```

Update the fonts cache with `fc-cache -r --force`.

Install GNOME Tweaks: `sudo dnf install -y gnome-tweaks`.
Open GNOME Tweaks and set fonts to:
- Interface Text: Microsoft Sans Serif Bold 11
- Document Text: Microsoft Sans Serif Regular 11
- Monospace Text: JetBrains Mono SemiBold 14
- Legacy Window Titles: Microsoft Sans Serif Bold 11

Hinting option: Slight
Antialising option: Subpixel (for LCD screens) or Standard (grayscale), see which fits better on the monitor.

### Display system information

There is good tools for that.
```bash
sudo dnf install -y htop btop fastfetch nvtop
```

* htop: displays usage of CPU, memory, swap and all running processes on the system.
* btop: same idea as htop but more fancy, more options and can be customized to fit your needs.
* fastfetch: a alternative to neofetch but faster as it's written in C.
* nvtop: displays GPU processes and VRAM usage.

For example, to see the birth of the filesystem, like when Linux was installed, run:
```bash
stats /
```

### Google Chrome
https://docs.fedoraproject.org/en-US/quick-docs/installing-chromium-or-google-chrome-browsers

Firefox is a very good browser, it's the Linux defaults but sometimes Chrome is needed for some websites. To install Chrome:
```bash
sudo dnf install -y fedora-workstation-repositories && \
sudo dnf config-manager --set-enabled google-chrome && \
sudo dnf install -y google-chrome-stable
```

If you have a multi-monitor setup with different refresh rates i.e. one 144Hz monitor as primary and a 60Hz secondary monitor then you must apply these flags on Chrome to really get 144 fps and not get locked at 60 fps.
- ignore-gpu-blocklist: Enabled
- enable-webrtc-pipewire-capturer: Enabled
- ozone-platform-hint: Auto or Wayland

To check whether Chrome refresh rate is synced with the hertz of the monitor, go to https://www.testufo.com and to check if the GPU is working properly go to chrome://gpu. You can also test hardware acceleration on OBS Studio or Discord by the way.

### OBS Studio

The cleanest way is to install it via Flatpak: `flatpak install flathub com.obsproject.Studio`.

### Discord

If the display server is Xorg (X11) then just install official Discord client via flatpak: `flatpak install flathub com.discordapp.Discord`.

Otherwise I recommend discord-screen-audio third party app because screen and audio sharing still does not works on the official Discord client due to a old version of Electron.
`flatpak install flathub de.shorsh.discord-screenaudio`

Keep in mind that screen sharing of Discord and any app on Wayland works 100% if you open with Google Chrome or Firefox.

### Podman

[Podman](https://podman.io) is built-in in Fedora, so it's not required to install Docker as Podman is a good replacement for the container implementation. However we need to install podman-compose and change SELinux mode to permissive or disabled to avoid permission issues when dealing with container scripts later. Keep in mind that is not a good practice disabling or set SELinux as "permissive" in any sense, specially for productions systems but for general day-to-day development, it's ok.
```bash
sudo dnf install -y podman-compose
sestatus
sudo vim /etc/selinux/config
# SELINUX=permissive
```

Podman Desktop (GUI): https://podman-desktop.io

To emulate Docker CLI with Podman:
https://podman-desktop.io/docs/migrating-from-docker/emulating-docker-cli-with-podman

```
sudo vim /usr/local/bin/docker

#!/usr/bin/sh
[ -e /etc/containers/nodocker ] || \
echo "Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg." >&2
exec podman "$@"
```

```bash
sudo touch /etc/containers/nodocker && sudo chmod +x /usr/local/bin/docker && \
docker run -it docker.io/hello-world
```

### Flatpak apps
Flatpaks can also be installed from https://flathub.org/apps or via GNOME software.

[**GIMP**](https://flathub.org/apps/org.gimp.GIMP): `flatpak install flathub org.gimp.GIMP` <br>
[**Telegram Desktop**](https://flathub.org/apps/org.telegram.desktop): `flatpak install flathub org.telegram.desktop` <br>
[**Github Desktop**](https://flathub.org/apps/io.github.shiftey.Desktop): `flatpak install flathub io.github.shiftey.Desktop` <br>

### Davinci Resolve

Download the executable installer from the Davinci Resolve [website](https://www.blackmagicdesign.com/br/products/davinciresolve).
After the installation, we need to be aware of some limitations of Davinci software on Linux. Here's some useful information:
- [Arch Wiki](https://wiki.archlinux.org/title/DaVinci_Resolve)
- [Painless Linux Video Worflow](https://passthroughpo.st/painless-linux-video-production-part-3-organization-and-workflow/)

### Other RPM apps

**Drawio:**
A free online diagram software for making flowcharts, process diagrams, charts, UML, ER and network diagrams.
```bash
cd /tmp && curl -L -O https://github.com/jgraph/drawio-desktop/releases/download/v21.6.8/drawio-x86_64-21.6.8.rpm && \
 sudo rpm -i drawio-x86_64-21.6.8.rpm && cd -
```

**Pencil:**
An open-source GUI prototyping tool that's available for all platforms.

```bash
cd /tmp && curl -L -O https://pencil.evolus.vn/dl/V3.1.1.ga/Pencil-3.1.1.ga.x86_64.rpm && \
 sudo rpm -i Pencil-3.1.1.ga.x86_64.rpm && cd -
```
