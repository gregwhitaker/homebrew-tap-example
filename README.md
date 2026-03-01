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

1. Push a Git tag (example `v1.0.0`).
2. GitHub Actions builds and uploads release assets:
   - `hello-brew-1.0.0.jar`
   - `hello-brew-1.0.0.jar.sha256`
3. In `Formula/hello-brew.rb`, set:
   - `url` to the release asset URL.
   - `sha256` to the value in `hello-brew-<version>.jar.sha256`.
4. Commit and push the formula update.

## Automated releases with GitHub Actions

This repository includes a release workflow at `.github/workflows/release.yml`.

When you push a tag like `v1.0.0`, GitHub Actions will:

1. Build `java-app/dist/hello-brew-1.0.0.jar` using `./gradlew`.
2. Generate `java-app/dist/hello-brew-1.0.0.jar.sha256`.
3. Create/update the GitHub release for that tag and upload both files as release assets.

## Install from this tap

```bash
brew tap gregwhitaker/tap https://github.com/gregwhitaker/homebrew-tap-example
brew install hello-brew
hello-brew
hello-brew "Homebrew user"
```

## Why this pattern works

- The JAR is treated as the distributed artifact.
- Homebrew verifies integrity with `sha256`.
- The wrapper script ensures `java -jar` runs with the tap's `openjdk` dependency.
