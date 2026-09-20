class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.13"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.13/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "e704abf5fc8364137866d1ff2cb5bd52374af331f5bc200645a63f6bf2c7e8b0"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.13/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "ccae8f50b8788a2e369ce23d997f00933b3a368381027ad89d7222a06a0b43ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.13/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b7348ce44f2860c4740e62f83151110b83bdac3bec600f7ad060df3efdecb773"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.13/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d44bbcf05c949fc8185a1339f391fe2e64de0f01463df842638915ded67ce722"
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
