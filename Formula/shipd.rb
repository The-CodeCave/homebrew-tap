class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.30"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.30"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "da2da49f21293aa3ef3337176f15b4adafa83122c9b9dedb9276f70c4d3086d7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "da2da49f21293aa3ef3337176f15b4adafa83122c9b9dedb9276f70c4d3086d7"
    sha256 cellar: :any_skip_relocation, big_sur: "31d85612787fe9903e57ebd9d07e8352ee8a3ebdf6abafa580a84db4e1a4b8c9"
    sha256 cellar: :any_skip_relocation, sequoia: "31d85612787fe9903e57ebd9d07e8352ee8a3ebdf6abafa580a84db4e1a4b8c9"
    sha256 cellar: :any_skip_relocation, arm64_linux: "5f0c67f73c85fab5cf1a02f65ea2d93d4ce28824a59e87f2762947c1d0df6de5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7c57dd33119c0dcea07d03312736cb9ecc61857f5a1105cac77fc5717eaf60f"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.30/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "63602bddf1217f81be8d5768a06aa9dae890351bd1eb79bd8ce8f16272a18a4f"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.30/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "e2849408fb6bf44d8e8c622e0aba47c0bf5caebc67499d4123e818b7a09ca7c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.30/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0202cc83d861a67c1e00755218aeeb15197e936de871121daad8f8a2bb26c773"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.30/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "46ac714186411f809f689de18b431c9a6725dcdb93b795366b4c842ad1cac077"
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
