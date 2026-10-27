class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.28"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.28"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3bdfd1ac47fdef0f5166a10462cbd66a4e69460c8b0a1a6fd4c551bab62ef9d2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3bdfd1ac47fdef0f5166a10462cbd66a4e69460c8b0a1a6fd4c551bab62ef9d2"
    sha256 cellar: :any_skip_relocation, big_sur: "b8df5a3ecd7e9dac82c09bb5f9ca7c38465e1029c1ffcbb6bb2f5e6f343aafe9"
    sha256 cellar: :any_skip_relocation, sequoia: "b8df5a3ecd7e9dac82c09bb5f9ca7c38465e1029c1ffcbb6bb2f5e6f343aafe9"
    sha256 cellar: :any_skip_relocation, arm64_linux: "f783e15f059766c6b24210cc78c8843e8f5e980d2c07095eefddfe2bb7735c91"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3fc6b7f3d671215d70e25e3f2f42b8382e884f13c3892c896a289b847d91adb5"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.28/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "03b3a717356d79b4fe57608d5e99d8cbe680c21dd6a95bee07ba8ca6da6b27fd"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.28/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "54d28f86ce44d6efc99627e150ba3ebf29d175fa588113f7f347521a0478760f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.28/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4dde166b71fb48a7a4127f066b5f6dc1523fb6d711c7311995eb42a6308d195"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.28/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "597995db39515af3e0ccbaebdb6506204ca591fffb74c4a5f09eeca96c631a7a"
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
