class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.2/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "bbd67c2c36c8c95ceb0e93588440441f0c8717ff78bb32486cc220a12fee0d4e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.2/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "38ead3ddd432318dfbdcc560c5273f5b13101d2b2500a69f273015dbfae5b794"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.2/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2a1ef2ffc24fd4e098f7532be32afdf4f424a8b854e997f6aaaec051eab3cf0b"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.2/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "93b48608d33548c4a747074afb3dd3c023496a30de6a4b8aa2281303b8bd0d97"
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
