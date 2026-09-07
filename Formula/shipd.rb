class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.1/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "83d5b4921f5662dc707c217dd3c29db5aaffb624e4883889b06894ab37f04b3f"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.1/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "a54a1a4bf6f98975a5cff7435d9aedc6c63e581a7176da450fdf4cd17ddb6077"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.1/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a750831f59384efd1cbb7caa810eb269fc9312cf0e5f2e1996f8e13cc0a55aa4"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.1/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "633ff99b577672f5ae40776ab31eced8236dec7d28aa0a1ee66def59cfee3163"
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
