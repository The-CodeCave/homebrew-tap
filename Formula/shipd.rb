class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.16"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.16"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "35e7afb659cef94c06e11e535231d47e33fbc0d5e1b3c4e329bd1b07a3623ddb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "35e7afb659cef94c06e11e535231d47e33fbc0d5e1b3c4e329bd1b07a3623ddb"
    sha256 cellar: :any_skip_relocation, big_sur: "54116b37a99d34430f1fd6c5202e6187dc8d144cc762586b56d289a3274f90bd"
    sha256 cellar: :any_skip_relocation, sequoia: "54116b37a99d34430f1fd6c5202e6187dc8d144cc762586b56d289a3274f90bd"
    sha256 cellar: :any_skip_relocation, arm64_linux: "ed423b30003ab6da42d9a58ff77610dfbd212e599c5d06e7136cd243e15aa994"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8108fb8ae1fea777357d7b05a7c37a0135f5e00b512ab3b363945535b0db117"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.16/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "2d7d482076cc27d415b860a01ec18943a3618742d0ded7b4c66bea75d37dd4e6"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.16/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "6d587a6838ada6c19d5778a72e375083a39793809f22bab51c4f3d1a54b5caa7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.16/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ba1b7bf3f1395d2eee146f1bafd6ea8ed589025ebbca16b611fa40d1e9c98e30"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.16/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2b9dfb2abeddd478abe446d84b1e4fdf1f72070e844d7d80d511ab224495e965"
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
