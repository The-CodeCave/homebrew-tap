class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.27"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.27"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ff8b0f0170032b7bb4f6edee1645c9fc6ef2397dd67b1d3580cec1dd3760ac6c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ff8b0f0170032b7bb4f6edee1645c9fc6ef2397dd67b1d3580cec1dd3760ac6c"
    sha256 cellar: :any_skip_relocation, big_sur: "14ad25092c168cdc0fc43c8ffec79923f56aed97d38b6d7d11740861861b8500"
    sha256 cellar: :any_skip_relocation, sequoia: "14ad25092c168cdc0fc43c8ffec79923f56aed97d38b6d7d11740861861b8500"
    sha256 cellar: :any_skip_relocation, arm64_linux: "f09b9b003e0e3becce64e810b25525c54b6985d7b738b8e79699d08e9a9e6728"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4236d5f6837e3e1ac0a27446b8648258c084466eb63ef238cf33c5307c6a24af"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.27/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "aced43754e151b95488f3d71ef0597225ddc742962c30f3ad9e0b4a7b667a423"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.27/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "6b546c2cafa75c62abbad91714d30eeef44aac62977cc0cab442273f1d6589f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.27/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eba2b85d7ef1ae3c8fa8afaeeac5afa4182d265368c2c2c3b30c5a3316b2a59c"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.27/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "552677e76b40b4f3d1e826074bf38a09d1743e6bdc206a27696413f42c3fde49"
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
