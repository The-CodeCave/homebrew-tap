class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.7/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "deb1a75d8bfeec32c52da6040b5ed4f011ad5d1e1c14c0dd0e32bedca1bd7671"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.7/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "2f663763de4070605c95e81a355b9e9ded472742985420e6625f7ecfbe79efed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.7/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "43e05b884a445c8bb0848225f8a91d1909e89966c21b33a92a1055e87c3263b1"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.7/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c3db3bfc3aa6ba761fc97b0656a31c6acc6cf395a9de9e048dca8c324333f456"
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
