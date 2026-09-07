class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.0/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "3b00b1fee54a911d4de2514281f23b193c9bd94529527c899ed0486f2d100de8"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.0/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "f0c7c48187d0704c25360e9d2ae83f6ae2b5c3928baa9b05a5d3e2984707ebd0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.0/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3873c2d28ba7ef82c32304a4f805745eb070924b559f8cc67f0bc3f5693d1df4"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.0/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "da2a02ff9feeb1e93dc0f69f8162c1c67796bd60ab9b8246236dd99dc3bd2e3a"
    end
  end

  def install
    bin.install "shipd"
  end

  def caveats
    "The current macOS artifacts are not Developer ID signed or notarized."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shipd --version")
  end
end
