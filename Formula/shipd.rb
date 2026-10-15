class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.19"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.19"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "142db27a74d204b60986e813ccaffc8025525c0c82209e7d794d4a5bb14df8d6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "142db27a74d204b60986e813ccaffc8025525c0c82209e7d794d4a5bb14df8d6"
    sha256 cellar: :any_skip_relocation, big_sur: "cb6e6505ed957d2b8690514e599e8d5265d3943fc089748ddb9047b5e7c8b74a"
    sha256 cellar: :any_skip_relocation, sequoia: "cb6e6505ed957d2b8690514e599e8d5265d3943fc089748ddb9047b5e7c8b74a"
    sha256 cellar: :any_skip_relocation, arm64_linux: "71fa9bd0eaa2c6502bae140c54565f97395e547bb4558ac41098ff570c0be8a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8c3354325a67ccb277d6d417e479e8c391490bd233dc93b3e0f80d0327d2d36d"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.19/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "b13e2bf4f6fd1f16507d351c548e6ccd18ddfc73c6ea6f88c85f8f0b4d2dcb6e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.19/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "acdb88aefa8658b001c754557d2a1988839700d1ebe1d3262ef703b14deaede3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.19/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c9aff1af4f8be855a151df0ad77320dac59d46635abb25331af6da9aded175ef"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.19/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "79de5f32e9154f412a7ec82843d84a23ad09c13e86e67dbe82994f14a61b49a9"
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
