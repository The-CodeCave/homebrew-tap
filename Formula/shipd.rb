class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.23"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.23"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3343ddaf709889b8d87589a6c24a48aedb0fadd37b7a2a8413066c29fe0ad123"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3343ddaf709889b8d87589a6c24a48aedb0fadd37b7a2a8413066c29fe0ad123"
    sha256 cellar: :any_skip_relocation, big_sur: "a76b12b8e215c8670c74b88fe4a945b377add842e67a4ce866a6170748d4db76"
    sha256 cellar: :any_skip_relocation, sequoia: "a76b12b8e215c8670c74b88fe4a945b377add842e67a4ce866a6170748d4db76"
    sha256 cellar: :any_skip_relocation, arm64_linux: "89d74c7ddb0acc325c5899ea688817803335beae67f3e680c7c545489f9c9ca9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "957e6adea0789453824e2d482ce521cfbb2964e251e30e093d06d02bcfc70b8f"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.23/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "0a67e3d3bec52508e27b2bbdfe7183b1ec8ad496aeb8b60a65adfc73eab25451"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.23/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "f6a6868efda81486e1f36a46daab4e51c312a742c64748b9ababebb57f439b65"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.23/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e680a9c8ba3732d45d7407ee1f90bee87adf47dce20a115a2e50be95cb568f48"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.23/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e8f8f5cbb63550fa6e4c009b6629e50b24409bc575959c372d154d98e8db356d"
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
