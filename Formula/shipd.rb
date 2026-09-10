class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.5/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "58dd16d093c4dd7b2788942826cfd8c84c813f536a3c763585a0b3a02b4edb51"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.5/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "af55de662a5e371fafce9a981a844e3ee52a5ca6110da0683c1afb6e5efd13c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.5/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5c84c788716996c08a955aa61846e5542e3aea7f748cabf68822610394041de9"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.5/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "19bb1253ac4d6a11b57ad86e262f7304f30acf88a13b5c48a0dea19ebf09c066"
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
