class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.10"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.10/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "a3823f3e9afbcbeb3ad68b6b49a59145a927f36e39ad7825fd0b9270f4823af7"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.10/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "414b253e7d22c944ce33aca945131fb736a122caeac80cba8b4d607414df759f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.10/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cf80707f90ef8ab96ae69bf91e2e23673d6ced3f7ea77153d3afff3a4727721e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.10/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "105d1235ee3ebf04c96e8828fdc1f3c172d60a1c882c2fd6109bc3188ffbd785"
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
