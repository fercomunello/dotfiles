# Dotfiles
* Files and folders that start with a dot (.) belong to the user’s home directory.
* The dotfiles are mapped via [symlinks](https://en.wikipedia.org/wiki/Symbolic_link).

### My workstation
<img src="https://i.imgur.com/PgaTfyf.png">
<img src="https://i.imgur.com/qczU8xy.png"> 

## Setup
First of all, install some Linux distro and install the required packages.

### Install essential packages
The following commands are for [Fedora](https://fedoraproject.org/pt-br/workstation/download/) and
[RHEL](https://developers.redhat.com/products/rhel) (Red Hat Enterprise Linux), may also work on [Oracle Linux](https://www.oracle.com/linux) and [Rocky Linux](https://rockylinux.org).

* **[Git](https://git-scm.com), [Github CLI](https://cli.github.com)**
```sh
sudo dnf install -y git gh
```

* **[Vim](https://www.vim.org):** A text editor built to make creating and changing any kind of text very efficient.
```sh
sudo dnf install -y vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

* **[Alacritty](https://alacritty.org):** A fast, cross-platform, OpenGL terminal emulator.
```sh
sudo dnf -y install alacritty
```

For GNOME desktop environment running on Wayland display server, you may want to reset WAYLAND_DISPLAY variable
if you prefer to disable client-side window decorations.
```sh
sudo cp /usr/share/applications/Alacritty.desktop ~/.local/share/applications
sed -i 's/^Exec=alacritty/Exec=env -u WAYLAND_DISPLAY alacritty/g' ~/.local/share/applications/Alacritty.desktop
```

Also, you may want to replace the default GNOME terminal with Alacritty's name and icon and then hide the old terminal app.
**Note:** You must log out to apply these changes.

```sh
sed -i 's/^Name=Alacritty/Name=Terminal/g' ~/.local/share/applications/Alacritty.desktop; \
sed -i 's/^Icon=Alacritty/Icon=org.gnome.Terminal/g' ~/.local/share/applications/Alacritty.desktop; \
sed -i '2i NoDisplay=true' org.gnome.Terminal.desktop
```

* **[ZSH](https://www.zsh.org):** A shell designed for interactive use, although it is also a powerful scripting language.
```sh
sudo dnf install -y zsh
sudo lchsh $USER
```

**Note:** You must log out to apply these changes.

This command should display something like: `zsh 5.9 (x86_64-redhat-linux-gnu)`
```sh
$SHELL --version
```

If something goes wrong, there is a trick to recover the shell dotfiles, also works for .bash files:
```sh
ls /etc/skel
cp /etc/skel/.zshrc ~
```

* **[Oh My ZSH](https://ohmyz.sh):** A zsh framework to unleash your terminal like never before.
Open a new terminal after running this command.
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Clone the repository
```sh
git clone https://github.com/fercomunello/dotfiles.git ~/.dotfiles
```

### Create the symbolic links
Now whenever you change some dotfile the system will recognize the changes on $HOME folder and subfolders.
```sh
ln -svf ~/.dotfiles/.zshrc ~/.zshrc ; \
ln -svf ~/.dotfiles/.gitconfig ~/.gitconfig ; \
mkdir -p ~/.config/alacritty && ln -svf ~/.dotfiles/.config/alacritty/* ~/.config/alacritty/* ; \
ln -svf ~/.dotfiles/.aliases ~/.aliases ; \
ln -svf ~/.dotfiles/.oh-my-zsh/custom/shortcuts.zsh ~/.oh-my-zsh/custom/shortcuts.zsh ; \
ln -svf ~/.dotfiles/.oh-my-zsh/custom/autocomplete.zsh ~/.oh-my-zsh/custom/autocomplete.zsh ; \
ln -svf ~/.dotfiles/.vimrc ~/.vimrc ; \
mkdir -p ~/.vim/UltiSnips && ln -svf ~/.dotfiles/.vim/UltiSnips/all.snippets ~/.vim/UltiSnips/all.snippets ; \
vim +PluginInstall +qall && mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d ; \
ln -svf ~/.dotfiles/.config/pipewire/pipewire-pulse.conf.d/custom.conf ~/.config/pipewire/pipewire-pulse.conf.d/custom.conf ; \
mkdir -p ~/.local/share/applications ; \
ln -svf ~/.dotfiles/java/applications/visualvm/visualvm.desktop ~/.local/share/applications/visualvm.desktop ; \
ln -svf ~/.dotfiles/.ideavimrc ~/.ideavimrc
```

Some dotfiles was created based on [Sebastian Daschner's](https://github.com/sdaschner/dotfiles) files:
 - as well as the effective developer approach, must watch this [presentation](https://www.youtube.com/live/mt4K6gHj5gE)! =)

## Why Fedora?
* The Fedora project is the upstream, community distro of RHEL. Red Hat is the project’s primary sponsor, but thousands of independent developers also
contribute to the Fedora project.
* Fedora comes with [Podman](https://podman.io) engine built-in, a very good implementation of containers, no need to install Docker manually.
* Fedora comes with a latest kernel version and well tested recent packages. 
* Fedora is the perfect combination of bleeding edge, stability and ease of use - it's as easy to use as Ubuntu, bleeding edge as Arch while being as free and stable (or close to) as Debian.
* The community is fantastic, always trying to push the Linux desktop forwards, and with RedHat, it has the money to do this.
* Technically, I feel Fedora is the most innovative and progressive force for desktop linux users.
* As RHEL, Oracle Linux and CentOS are heavily used on enterprise, you can avoid context switching as will be more familiarized with this kind of environment.
* If you prefer an alternative vanilla DE other than GNOME you can download a [Fedora Spin](https://fedoraproject.org/spins).

--------------------------------

<div align="center">
  <small>By Fernando Comunello - <strong>Aug/2023</strong></small><br>
</div>

