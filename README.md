# homebrew-tap-example

Example tap that distributes a prebuilt executable Java JAR.

## Repository layout

- `Formula/hello-brew.rb`: Homebrew formula that installs the JAR into `libexec` and creates a wrapper executable in `bin`.
- `java-app/src/main/java/com/example/HelloBrew.java`: Sample Java CLI app.
- `java-app/build.gradle`: Gradle build that packages the executable JAR.

## Build the executable JAR (Gradle Wrapper)

```bash
cd java-app
./gradlew clean releaseJar -PappVersion=1.0.0
```

This creates:

- `java-app/dist/hello-brew-1.0.0.jar`

Print the SHA256 for the formula:

```bash
cd java-app
./gradlew printSha256 -PappVersion=1.0.0
```

## Publish and wire up Homebrew

1. Create a GitHub release tag (example `v1.0.0`).
2. Upload `java-app/dist/hello-brew-1.0.0.jar` as a release asset.
3. In `Formula/hello-brew.rb`, set:
   - `url` to the release asset URL.
   - `sha256` to the value output from `./gradlew printSha256 -PappVersion=<version>`.
4. Commit and push the tap.

## Install from this tap

```bash
brew tap gwhitake/tap https://github.com/gwhitake/homebrew-tap-example
brew install hello-brew
hello-brew
hello-brew "Homebrew user"
```

## Why this pattern works

- The JAR is treated as the distributed artifact.
- Homebrew verifies integrity with `sha256`.
- The wrapper script ensures `java -jar` runs with the tap's `openjdk` dependency.
