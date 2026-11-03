class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.32"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.32"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b209e42b892c3f355d7fe69d53d7c20c1a9eec2b37465492b2f9859c6fe06bfc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b209e42b892c3f355d7fe69d53d7c20c1a9eec2b37465492b2f9859c6fe06bfc"
    sha256 cellar: :any_skip_relocation, big_sur: "35223a23abca118cb040aa43fa672b456f2fab3863c3511517ef6088e4abe0fe"
    sha256 cellar: :any_skip_relocation, sequoia: "35223a23abca118cb040aa43fa672b456f2fab3863c3511517ef6088e4abe0fe"
    sha256 cellar: :any_skip_relocation, arm64_linux: "05032ef4401ae86b562778e55baaa93450b8e7f80822c680a67eb8ed3c1dbefb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3812dabc2f9099ff2a9440f179678a7dcd59442c397729bbf3b6daa61eae8b24"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.32/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "94842a82ae4500cb0c7c06dbbc02014955aac61e0bf9306f8d5f042dad8564a3"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.32/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "89121afb22c5d32dddfc1b9416a176d848ba81b7d2f1a6fa0cd58e93e2980cdf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.32/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "737ed5625d0368528fe8ab5773369da6ba0fd914a325faee77685563f7399361"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.32/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dbd8026fbc72769a9c8ace4dbf19e9f885109b22071cd10c18c9a3ba1da2e71c"
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
