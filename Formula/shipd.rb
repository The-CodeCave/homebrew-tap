class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.22"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.22"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "83c1869fcf56c1ccef92589fbc7a1fb25607d8eb01ed0b8ea32afae74e2faa01"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "83c1869fcf56c1ccef92589fbc7a1fb25607d8eb01ed0b8ea32afae74e2faa01"
    sha256 cellar: :any_skip_relocation, big_sur: "06c2d7ff22b9330d63a9cf232cc794ac69e4721f4534e3620f52cca1aa09d1ba"
    sha256 cellar: :any_skip_relocation, sequoia: "06c2d7ff22b9330d63a9cf232cc794ac69e4721f4534e3620f52cca1aa09d1ba"
    sha256 cellar: :any_skip_relocation, arm64_linux: "2f021d5b88cd19d49d458c4ee86f92265cc1898759e838bacbec719251ada9a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "19f468debc8a0978224e43bb1d27c4880834463d005bac10435f839036100eda"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.22/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "ebc839aeefa31281fcef81dd14bb73467cae1b71f1d2eb38fc61e9203a88c82e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.22/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "53c391532bd9e74ee28083acf1b54c09347af53e72e62f1f138c05230f167339"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.22/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bebe692298e845330b3f3b4da5e406cab8ac7d7f79fbae1099b4919832379664"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.22/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c5156a160bec4f642b48bf8bb79d01d8cb829ab4fcde391ddb192df22d8248cf"
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
