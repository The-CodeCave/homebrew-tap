class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.24"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.24"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b01272f00b3cd3bbaa921b7d3fb47a4a15352efbe12133e5d95a259e066ec538"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b01272f00b3cd3bbaa921b7d3fb47a4a15352efbe12133e5d95a259e066ec538"
    sha256 cellar: :any_skip_relocation, big_sur: "76809c444f9658ff4757b484a0f641b8fe95fbd77f489888098dd9708ed91838"
    sha256 cellar: :any_skip_relocation, sequoia: "76809c444f9658ff4757b484a0f641b8fe95fbd77f489888098dd9708ed91838"
    sha256 cellar: :any_skip_relocation, arm64_linux: "3aa05750b11582e1c7fe63721c06a4182b3c85e35c67a99c9d01051fa71a78ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9507e1ffbf9d5f3456b9a33902a181f77d43be6d9811f8ec9dc161226d75f09a"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.24/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "407ff6fc1c551962b38ad66f6412b67cbdc232ab385acd39918930e81693789e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.24/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "8b2e77c37d16f00036f7ea6ee485eda4891c30564b73842a8760bd318afa2776"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.24/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b98ec6f02736d19b4a0025711124cf1bc9c065ecc03e50f5679a83d3410d5d8c"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.24/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "14681229303d354c41e070f00bae6b312b6242ba6951cb7a9cfd3c68eb78f165"
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
