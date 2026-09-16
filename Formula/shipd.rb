class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.8/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "c84fe1d1e06e4b75db143ca27cf57b9cefa11b253e6821b9531c05d263fca89c"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.8/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "d730f76c3b64249b90b5bd438f746824b7f7a42c854f52bcac9c05c5f55ebcc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.8/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b3f67e048e45c793541f9e6e2adfcafaca85748841c05f10b5988607ccb852c7"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.8/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b9c997ad5c110e9d6d30b486d436664bd646cbdf884b9bc52e828b71fa26449e"
    end
  end

  def install
    bin.install "shipd"
  end

  def caveats
    "This legacy release is not Developer ID signed or notarized." if version == Version.new("0.1.0")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shipd --version")
  end
end
