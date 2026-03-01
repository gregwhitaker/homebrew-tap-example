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

1. Open GitHub Actions and run the `Release JAR` workflow manually.
2. Provide a version without `v` (example `1.0.0`).
3. The workflow will:
   - Build `hello-brew-<version>.jar` and `hello-brew-<version>.jar.sha256`.
   - Update `Formula/hello-brew.rb` URL and SHA256.
   - Commit the formula update to the repository default branch.
   - Create and push tag `v<version>`.
   - Create/update the GitHub release and upload both assets.

## Automated releases with GitHub Actions

This repository includes a release workflow at `.github/workflows/release.yml`.

When you run it with version `1.0.0`, GitHub Actions will:

1. Build `java-app/dist/hello-brew-1.0.0.jar` using `./gradlew`.
2. Generate `java-app/dist/hello-brew-1.0.0.jar.sha256`.
3. Update and commit `Formula/hello-brew.rb` with the matching URL and SHA.
4. Create tag `v1.0.0`.
5. Create/update the GitHub release and upload both files as release assets.

## Install from this tap

```bash
brew tap gregwhitaker/tap https://github.com/gregwhitaker/homebrew-tap-example
brew install hello-brew
hello-brew
hello-brew "Homebrew user"
```

## License
MIT License

Copyright (c) 2026 Greg Whitaker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
