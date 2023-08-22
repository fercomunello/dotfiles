# Install Java SDKs

### SDKMAN!
Meet [SDKMAN!](https://sdkman.io) – your reliable companion for effortlessly managing multiple Software Development Kits on Unix systems.

```bash
curl -s "https://get.sdkman.io" | bash ; \
  source "$HOME/.sdkman/bin/sdkman-init.sh" ; \
  sdk version
```

### Eclipse Temurin JDK
```bash
sdk install java 17.0.8-tem
sdk install java 11.0.20-tem
sdk install java 8.0.382-tem
```

### Oracle GraalVM
```bash
sdk install graalvm 17.0.8-graal
```

### Maven & Gradle
```bash
sdk install maven
sdk install gradle
```

### CLIs
```bash
sdk install quarkus
sdk install springboot
```

### VisualVM
```bash
sdk install visualvm
```

### Init environment with ~/.sdkmanrc file
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
