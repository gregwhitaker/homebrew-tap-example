class HelloBrew < Formula
  desc "Example Java CLI distributed as an executable JAR"
  homepage "https://github.com/gregwhitaker/homebrew-tap-example"
  url "https://github.com/gregwhitaker/homebrew-tap-example/releases/download/v1.0.0/hello-brew-1.0.0.jar"
  sha256 "ebb3e032dcca824e5dcf655a0199926a86405e7191897b0a176028787c046b83"
  license "MIT"

  depends_on "openjdk"

  def install
    libexec.install "hello-brew-#{version}.jar" => "hello-brew.jar"

    (bin/"hello-brew").write <<~EOS
      #!/usr/bin/env bash
      export JAVA_HOME="#{Formula["openjdk"].opt_prefix}"
      exec "#{Formula["openjdk"].opt_bin}/java" -jar "#{libexec}/hello-brew.jar" "$@"
    EOS
  end

  test do
    assert_match "Hello from a Homebrew-installed Java JAR!", shell_output("#{bin}/hello-brew")
    assert_match "Hello, Codex!", shell_output("#{bin}/hello-brew Codex")
  end
end
