class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.3/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "6769804dd5ef3b5b050ddcb709aa332266d251a69781f1346488b01aa243e9a0"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.3/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "1678d311f68eb22159d11e053f098ce76d861ccea1b31debf53e7250d88aeae8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.3/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "70dc8b8b63219b35df57f97d63fff49e575bc538f56943c6ed69d6f48f172515"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.3/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "75c00aa925edfff1f671a5da64cdd6260f6c324fd2a263322a198d350119232d"
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
