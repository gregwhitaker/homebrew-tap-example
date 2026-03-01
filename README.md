# homebrew-tap-example

Example tap that distributes a prebuilt executable Java JAR.

## Repository layout

- `Formula/hello-brew.rb`: Homebrew formula that installs the JAR into `libexec` and creates a wrapper executable in `bin`.
- `java-app/src/main/java/com/example/HelloBrew.java`: Sample Java CLI app.
- `java-app/build.gradle`: Gradle build that packages the executable JAR.

## Release process (GitHub Actions)

This repository uses `.github/workflows/release.yml` as the release workflow.

1. Push your latest changes to the default branch.
2. In GitHub, go to `Actions` -> `Release JAR` -> `Run workflow`.
3. Enter a semantic version without `v` (example `1.0.0`) and run it.
4. The workflow will:
   - Build `java-app/dist/hello-brew-<version>.jar`.
   - Generate `java-app/dist/hello-brew-<version>.jar.sha256`.
   - Update `Formula/hello-brew.rb` `url` and `sha256`.
   - Commit the formula update to the default branch.
   - Create and push tag `v<version>`.
   - Create/update the GitHub release and upload both assets.

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
