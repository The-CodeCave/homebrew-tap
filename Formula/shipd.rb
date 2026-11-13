class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.34"
  license :cannot_represent

  # This block is why `brew install` needs no Xcode or Command Line Tools.
  # `FormulaInstaller#install` only reaches `perform_build_from_source_checks`
  # and `UnbottledError` when `pour_bottle?` is false, and on macOS that check
  # list includes `check_xcode_minimum_version` -- so without a bottle Homebrew
  # demanded a current multi-gigabyte Apple toolchain purely to unpack an
  # already-notarized tarball, and failed outright one Xcode release behind.
  #
  # `cellar: :any_skip_relocation` is load-bearing, not cosmetic: it is what
  # makes `pour` skip `relocate_dynamic_linkage`, which rewrites install names
  # and ad-hoc re-signs -- destroying the Developer ID signature and the
  # notarization this pipeline paid for.
  #
  # `rebuild` is pinned at 0 and must stay there. `Bottle::Filename#extname`
  # splices it into the asset name, and the release that name points at is
  # immutable, so a bumped counter would send every install to an asset that
  # can never be uploaded. A bad bottle is fixed forward with a new patch.
  #
  # The `on_macos`/`on_linux` stanzas below remain the fallback for a tag this
  # Homebrew does not know -- not for a failed fetch, which raises.
  bottle do
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.34"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f38c1495fcbf883888758d3ac909bf849e396c83ede7788f41b8512d9e279dac"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f38c1495fcbf883888758d3ac909bf849e396c83ede7788f41b8512d9e279dac"
    sha256 cellar: :any_skip_relocation, big_sur: "bda5ba4bff926b3427af30314012276c1f9be324561547a103f7a4db115eb052"
    sha256 cellar: :any_skip_relocation, sequoia: "bda5ba4bff926b3427af30314012276c1f9be324561547a103f7a4db115eb052"
    sha256 cellar: :any_skip_relocation, arm64_linux: "350a151ae1415aa4e14a8ef936af0a5cb11543b0e9988ced0f54fcc210b91c7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7a029eacbdc8065773948fa128528c6a6813d4e03229da14257239ac454d5e57"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.34/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "de124bec84fb1a93673522001af47c3378934ded825981eba899190619071c8e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.34/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "e0e0db4d0c2a8d130764338c7485fd9797e88772c7fcad71d92b2039d74d1112"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.34/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c4c6bbacaa6a339aff9889949ba65368b99e75a3efc4712163c570020f69a199"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.34/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a1cafa2d0298ab1464fecf34d948fc7a6801d7a7ba15e720d6dbf4d2c9d12a18"
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
