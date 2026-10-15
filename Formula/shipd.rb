class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.18"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.18"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1b613b8a27e3ffa25f9e15da160dc8d9ca924c2903067d40e396585392f53504"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1b613b8a27e3ffa25f9e15da160dc8d9ca924c2903067d40e396585392f53504"
    sha256 cellar: :any_skip_relocation, big_sur: "a4b651071506c26b23a249183e4f0332a7084ac037a437a97add552c5b517325"
    sha256 cellar: :any_skip_relocation, sequoia: "a4b651071506c26b23a249183e4f0332a7084ac037a437a97add552c5b517325"
    sha256 cellar: :any_skip_relocation, arm64_linux: "51fbb037b25c383fa4860e8db39a0e2359207506345e349fbf696d4ba5353d21"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3fdee9ce1ccf60d1e1e317d16b0f4ba3e4005012849291464b0f0e43d7a8ee40"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.18/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "d8968cd0697ec20791f838ac563576985d477446f6b303af7495a68dc992a9c6"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.18/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "eb5ef5aa677e7692b9e3a6f7ffaaea9fdd27309ac0e89bc14fbe36f375b7609f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.18/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0b307d6aa4458c2c9966c2b25fa7be4c98860d08b9748227825f5b317a136691"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.18/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "de62f06ceedd2e8181f0706adf266a10f28a011f094de61589435c536f9676f6"
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
