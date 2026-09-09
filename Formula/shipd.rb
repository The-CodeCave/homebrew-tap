class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.4/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "7b7e0d1310a50076af829d36d4d752a0403f62e6945f90c0514e46a4a8707a41"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.4/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "7306a79ed7379553e210f4add0ccb2cc5a55538994a22d1bfc98d0f3bfc76e7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.4/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3bb0c7642f24a4250ec3b8b94f2a7f626e04e265b7e405df28e626edfae2cc6b"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.4/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e660f8a767608da18a3f562891d9ee25d70f04f9ed043c9aee0d7da2c2796d64"
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
