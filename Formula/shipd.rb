class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.20"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.20"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "29bc0fa468fcdae803e1f8b20f023309f5132278666ec1b5e53e01bd4f6bf237"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "29bc0fa468fcdae803e1f8b20f023309f5132278666ec1b5e53e01bd4f6bf237"
    sha256 cellar: :any_skip_relocation, big_sur: "e1ae3644266757caa35d0856ed4fdd71d2fda9c1dfb2490485f8f213f3f86685"
    sha256 cellar: :any_skip_relocation, sequoia: "e1ae3644266757caa35d0856ed4fdd71d2fda9c1dfb2490485f8f213f3f86685"
    sha256 cellar: :any_skip_relocation, arm64_linux: "c004d244909b9dbe8c3e0d9be02a96394a5570b9fe0f69e1d2f779303fee2651"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9537abda2bc69f15fd7f7b77a16372dc475c9e9fe35c6940e405125d5c0207d"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.20/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "e84750822ad82e935b40f49e7fa5ec12fb6d2a82e7e8e9aa83ef84edaaf0e28f"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.20/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "4af0d9b52e4fbf181dbb91ef04286324cbdfc585e6c86720da7195c2ef2368d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.20/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0d3c5f77ef188ccd5e50b04911e8bc772af1378d31e2ddecb231341798c89796"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.20/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "035b455a03f83451d8689a7663ab41f62ad56c223208422fb7418e5c51195d80"
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
