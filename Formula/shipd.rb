class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.33"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.33"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "18dff0a72f3f266d67c0defd0f73ed55b4e5d6a1169cacb85c63dab14f25be97"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "18dff0a72f3f266d67c0defd0f73ed55b4e5d6a1169cacb85c63dab14f25be97"
    sha256 cellar: :any_skip_relocation, big_sur: "1dfb6f51a7fe6a0ecfda1c5bfb0980df8139e896f337f3decb3e9da8eb676002"
    sha256 cellar: :any_skip_relocation, sequoia: "1dfb6f51a7fe6a0ecfda1c5bfb0980df8139e896f337f3decb3e9da8eb676002"
    sha256 cellar: :any_skip_relocation, arm64_linux: "11e71e6b6dea688d0f9dab6fff0be0f439525fe2d93698057b36ba1f22bd303a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0f7798bf57147dae21e9f9ba6ca5b5006c87243564a74201aa40576f021703fa"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.33/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "78fbb5e4b48f1da51036e7d49af6358afb3158d343343f349579bff7f6fc6894"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.33/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "8d6494caf4bf9b3eb97a82d7f855ef31953c4f1c5813ad94d9555e9f7dc2f091"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.33/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1288580fef384f7d16be31e0c45823e5ac0b6da3d3ed4311693d1e9816a0e06b"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.33/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80ae86f03c63fc160a93b9b33daa29863ca906c58438b4b00628993bd38fc25a"
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
