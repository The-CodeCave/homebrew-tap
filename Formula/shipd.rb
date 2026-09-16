class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.9/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "315fe000854c0b89d65621dfd4fc489d0435dac5db4aeeb811fcbc953f9db337"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.9/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "525cdb51fc74b887acf0927fb9259a4de8c0910e63cfb04cbb6ec5b976e96041"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.9/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bf558e42b8ca75ee3bf09361ebdc167824cbc314b083f4b3f681b72810582816"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.9/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0c33ccad7e4769ff3f8a23808154a17fdc6c2fcd6306ed99f8bcea2ac4544d0b"
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
