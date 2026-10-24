class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.25"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.25"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "211867483e64f1ec2171242a81fe491ba8ca4e5ce74b4f4efbf671b47920b395"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "211867483e64f1ec2171242a81fe491ba8ca4e5ce74b4f4efbf671b47920b395"
    sha256 cellar: :any_skip_relocation, big_sur: "83eee493c9020f38d6c4ed9e37ca754cea4fc3ae1dbf294b51c7f28efef70b55"
    sha256 cellar: :any_skip_relocation, sequoia: "83eee493c9020f38d6c4ed9e37ca754cea4fc3ae1dbf294b51c7f28efef70b55"
    sha256 cellar: :any_skip_relocation, arm64_linux: "12354291d2e3751d3aa89bf7ba3638be697b2ae7d8c319b3e3b22f770fec7fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b2c1d714f34373f1fe1cdb9ef6fbb578b63c2001a45c10e6cdc8b1edd3a43da"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.25/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "490412cdeecc7edf5db972d2340c10c668a857b368e97a56b640dfa6708720a1"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.25/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "962e8cf52da773d75a8586cfaa3a68dab2ed943b25077253b4ac043e67d0aba6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.25/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ba9c4ae0e5a0c3996ef35c1246e913ab33b6f5c784d4594ab99d14822a77bdca"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.25/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "84c8c8d5a2435e0d755eed3c31c2e046a7d71004da28a5b51a5bfb9da4140cce"
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
