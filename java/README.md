# Java Dev Environment

## Install Java & GraalVM

### SDKMAN!
Meet [SDKMAN!](https://sdkman.io) – your reliable companion for effortlessly managing multiple Software Development Kits on Unix systems.

```bash
curl -s "https://get.sdkman.io" | bash ; \
  source "$HOME/.sdkman/bin/sdkman-init.sh" ; \
  sdk version
```

### Eclipse Temurin JDK
**TL;DR.** 
✅ <br>
**Recommendation**: Use Adoptium Eclipse Temurin 17 and ensure that your local version 
matches the CI and production version. 
Otherwise, take a look on these great [alternatives](https://whichjdk.com) of the OpenJDK distribution.

```bash
sdk install java 17.0.8-tem
sdk install java 11.0.20-tem
sdk install java 8.0.382-tem
```

### Oracle GraalVM
```bash
sdk install graalvm 17.0.8-graal
```

## Install Tools

### Build Tools
```bash
sdk install maven
sdk install gradle
```

### Command-line apps
```bash
sdk install quarkus
sdk install springboot
```

### Create ~/.sdkmanrc file
```bash
sdk env init && sdk env install
sdk use maven <tab>
sdk use java <tab>
sdk use gradle <tab>
```

### Check versions
```bash
java -version
mvn -v
gradle -v
```

## Troubleshooting Tools

### VisualVM
All-in-One Java Troubleshooting Tool

```bash
cd /tmp && curl -L -O https://github.com/oracle/visualvm/releases/download/2.1.6/visualvm_216.zip && \
unzip visualvm_*.zip && sudo rm -rf /opt/visualvm && sudo mkdir -p /opt/visualvm && \
sudo mv -v visualvm_*/* /opt/visualvm && \
sudo cp ~/.dotfiles/java/applications/visualvm/icon.png /opt/visualvm && \
update-desktop-database ~/.local/share/applications && cd - > /dev/null
```

