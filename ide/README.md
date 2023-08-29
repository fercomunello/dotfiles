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
**Github Theme:** https://plugins.jetbrains.com/plugin/15418-github-theme <br>
**Naruto Progress Bar:** https://plugins.jetbrains.com/plugin/19302-naruto-progress <br>
**Mario Progress Bar:** https://plugins.jetbrains.com/plugin/14708-mario-progress-bar

### My custom color scheme

#### Dark
**Theme:** Dark <br>
**Color Scheme:** Dark_Liquid.jar|icls <br>
**Font:** JetBrains Mono NL SemiBold <br>
**Font size:** 19 <br>
**Line height:** 1.3 <br>
**Background:** Solid Black <br>
**IDE Zoom:** 100% <br>
**IDE Font:** SF Pro (Apple) - Size: 15

#### Light
**Theme:** Light (default) <br>
**Color Scheme:** IntelliJ Light (default) <br>
**Font:** JetBrains Mono NL Regular <br>
**Font size:** 19 <br>
**Line height:** 1.3 <br>
**IDE Zoom:** 100% <br>
**IDE Font:** Segoe UI (Microsoft) - Size: 13/14

