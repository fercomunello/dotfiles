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

### My custom color scheme

#### Dark
**Theme:** Dark <br>
**Color Scheme:** Dark_Liquid.jar|icls <br>
**1º Font:** JetBrains Mono NL Medium <br>
**2º Font:** Consolas Regular <br>
**Font size:** 19 <br>
**Font size (presentation):** 24 <br>
**Line height:** 1.3 <br>
**Background:** Solid Black - 50% opacity <br>
**IDE Zoom:** 100% <br>
**IDE Font:** Segoe UI (Microsoft) - Size: 14

#### Light
**Theme:** Light (default) <br>
**Color Scheme:** IntelliJ Light (default) <br>
**1º Font:** JetBrains Mono NL Regular <br>
**2º Font:** Consolas Regular <br>
**Font size:** 19 <br>
**Line height:** 1.3 <br>
**IDE Zoom:** 100% <br>
**IDE Font:** Segoe UI (Microsoft) - Size: 13/14

### Plugins
**IdeaVim:** https://plugins.jetbrains.com/plugin/164-ideavim <br>
**Github Theme:** https://plugins.jetbrains.com/plugin/15418-github-theme <br>
**Mario Progress Bar:** https://plugins.jetbrains.com/plugin/14708-mario-progress-bar <br>
**Naruto Progress Bar:** https://plugins.jetbrains.com/plugin/19302-naruto-progress <br>

### Changed Keymaps
Editor Actions 
  -> Decrease Font Size: CTRL+Minus
  -> Increase Font Size: CTRL+=
  -> Paste: Shift+Insert
  -> Paste as plain text: CTRL+V
  -> Reset Font size: CTRL+0

Code -> Folding
  -> Expand: CTRL+NumPad+
  -> Collapse: CTRL+NumPad-

Build
  -> Build Project: ALT+S
  -> Build Artifacts: CTRL+Shift+9

Window -> Editor Tabs -> Editor Close Actions 
  -> Close Tab: CTRL+W
