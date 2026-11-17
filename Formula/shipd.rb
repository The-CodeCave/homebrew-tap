class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.41"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.41"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2d92efbc5a26fb429e34a1816eb7832df75bbcf28471328e76134086182572ee"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2d92efbc5a26fb429e34a1816eb7832df75bbcf28471328e76134086182572ee"
    sha256 cellar: :any_skip_relocation, big_sur: "cc0ef3452eeea6d923fb41f5922bd59078021d7458d8d4c7daa23d413a5f75cf"
    sha256 cellar: :any_skip_relocation, sequoia: "cc0ef3452eeea6d923fb41f5922bd59078021d7458d8d4c7daa23d413a5f75cf"
    sha256 cellar: :any_skip_relocation, arm64_linux: "44339f22dfd1f024e71c9663d6c24d3f5a24c3b82bbc3d48fcf7afe086f57447"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9e66c32d34cfbbe97c54a5510daec7377e2b420bc072bf8d38d16496f471b4ec"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.41/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "b60199158b9a98a51236ebb6636f0c4615f6b72880c109a162ae51151e71b39c"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.41/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "2746482b6804e2d495bfb9e59f7b28af424ca27c75760375ef0957eebcd7ff33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.41/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5c8d3a68081e60f6baf28c9859e6c8900ae3dce71f216a9dbeef35e9f91d6329"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.41/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a6eed2d08e0482f8d99fee44dad8e926423b62d36f66e4575b9399a3f66acb4a"
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
