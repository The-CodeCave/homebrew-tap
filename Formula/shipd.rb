class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.31"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.31"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "aca48c28451716ad1c9d83ffd17faee3ecce62a74d26c99a453133c3c861c0f7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aca48c28451716ad1c9d83ffd17faee3ecce62a74d26c99a453133c3c861c0f7"
    sha256 cellar: :any_skip_relocation, big_sur: "9d85f08f8fb3aa2440fefd651131120e47dbdcfb37e54286053e1844d9cbac20"
    sha256 cellar: :any_skip_relocation, sequoia: "9d85f08f8fb3aa2440fefd651131120e47dbdcfb37e54286053e1844d9cbac20"
    sha256 cellar: :any_skip_relocation, arm64_linux: "bffc7c793a26f029e8492c9e19d6f0a3128deabcea3c83b43897a9363f8df729"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62df7a8e00bf4df2b512e015fa57f393f63768a7f69d98134f53c6157720171d"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.31/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "6940f6e50dd3a4e062d38eff17c14e4bf7fe5ab06e981af8ba4a2724f7ae866d"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.31/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "0944dc73337db83edd4d4cbf2247f847e9dc155614d8eeab4a41e8970b780486"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.31/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d18b477327f8acc8a14dc1c0902ba856427e87ea9eb30b0fd5a29396e72343a9"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.31/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "985f0fb939e3e630bc7b4d46a99061e1aadbc0cf56de7330cf75c728b1c7d26c"
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
