class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.21"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.21"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9d5d7201108469cba52e08917bbcc310df676f667d19de369dc0b521a7e03047"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9d5d7201108469cba52e08917bbcc310df676f667d19de369dc0b521a7e03047"
    sha256 cellar: :any_skip_relocation, big_sur: "1baa3cafbd21986ddc8959ab978389c56b10319c3b91025a636d6b010af94b82"
    sha256 cellar: :any_skip_relocation, sequoia: "1baa3cafbd21986ddc8959ab978389c56b10319c3b91025a636d6b010af94b82"
    sha256 cellar: :any_skip_relocation, arm64_linux: "78655d4d396075026801cef1ec5d4234317a7ef8a0bce01623aa8de2bed6ee5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b2df614e2e89831986d7aa063736b64cb5835d139cb3377340a517f74c102791"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.21/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "6993b0d4cfcbfd8fc3683386a0e52396725f090e422330a07f315c7851d30780"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.21/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "ed3ea34cc8e0b4a1827480142f6a4bfeafc862862c779c6fcb5a0922e8fd7885"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.21/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "669f0d56faefaad34d75d56b8d45dde689f3748a883bf06fc39e88e61b74c051"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.21/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bda26b39984cf0580432e37a3b2cb02fb0a47531c8d100c26bcbf0cb6efa0982"
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
