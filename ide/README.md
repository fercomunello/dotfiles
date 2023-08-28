# IDE setup

## IntelliJ IDEA Ultimate
IntelliJ IDEA Ultimate is a superset of most JetBrains IDEs.
https://www.jetbrains.com/idea/download/?section=linux

### Installation

First, download the .tar.gz file.

```bash
cd ~/Downloads && \
tar -xvzf idea*.tar.gz && mv idea*/ intellij-idea && \
sudo mv intellij-idea /opt && \
sudo ln -svf /opt/intellij-idea/bin/idea.sh /usr/bin/idea && \
sh /opt/intellij-idea/bin/idea.sh
```

Go to IDE Settings/Tools > Create Desktop Entry and check "create entry for all users (require sudo).

Exit the IDE and open via DE panel.

### Plugins
**IdeaVim:** https://plugins.jetbrains.com/plugin/164-ideavim <br>
**Github Theme:** https://plugins.jetbrains.com/plugin/15418-github-theme 

### My custom color scheme

#### Dark
**Theme:** Github Dark High Contrast <br>
**Color Scheme:** Dark_Liquid_theme.jar|icls <br>
**Font:** JetBrains Mono SemiBold <br>
**Background:** Solid Black 

#### Light
**Theme:** Light (default) <br>
**Color Scheme:** IntelliJ Light (default) <br>
**Font:** JetBrains Mono Regular


