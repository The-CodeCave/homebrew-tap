class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.11"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.11/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "72d173a21642ac94f4af1a5a226fd66aeda5b038f5b91e6db2e9a4b1b4945aa1"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.11/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "b008e2ebfd845b385c3aa6d197c9dee5334e0e845cf0203b417da246c38afc63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.11/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f87b2225e54263d1dc50c05854d7c494d253a0921581874c8c10f7bb983bd792"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.11/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5be7114ca8453942990b687cc7dc1c168592182dedf1642ca3857c0b555fa876"
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
