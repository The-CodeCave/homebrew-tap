class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.40"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.40"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e731d7939d5de3cc9b29971cd4e6462675affd1dcdd43fb884574185293f19e1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e731d7939d5de3cc9b29971cd4e6462675affd1dcdd43fb884574185293f19e1"
    sha256 cellar: :any_skip_relocation, big_sur: "593211678db693c87d2a943ade4dfb01997b4aba1a020332d54e936363ccf1a1"
    sha256 cellar: :any_skip_relocation, sequoia: "593211678db693c87d2a943ade4dfb01997b4aba1a020332d54e936363ccf1a1"
    sha256 cellar: :any_skip_relocation, arm64_linux: "8a58a68d8cde4d1edd244e1f05f67307cb3f6bb7573d5f4aad13c35b8431f725"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac39811b7fcf5c9513e4f9f9179ec1ed1a4ef0f01c5b21d7cc7e3f4acd0aad3d"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.40/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "1ae96a6f6e7f2790fef6e18e9fdac5bf3971d75ed2c52cd34bc59cac2b220297"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.40/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "bfa89c28eb0e3a24d2b6e0de1f6eb722a31fbe8abf96dc26f4ffba8b43e9b70f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.40/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f05a578530f0b7cfe530abd8293c9a5965e69d97e1bf62cd68dc12e397599ec5"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.40/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4ead145fac164bffb2db3767470d287aac40e8fd671b611004771b05ecd0042b"
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
