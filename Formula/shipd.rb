class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.35"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.35"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "61e44ac1b74e546941ef21512dc8ea0a84599f6bfd547843ac58e29d48869f6d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "61e44ac1b74e546941ef21512dc8ea0a84599f6bfd547843ac58e29d48869f6d"
    sha256 cellar: :any_skip_relocation, big_sur: "31d0fb909475fe781b22bfb4dcb385c2f57a1f834e61f3b3125b72beba9239c0"
    sha256 cellar: :any_skip_relocation, sequoia: "31d0fb909475fe781b22bfb4dcb385c2f57a1f834e61f3b3125b72beba9239c0"
    sha256 cellar: :any_skip_relocation, arm64_linux: "779ebc71854ebebc12af90f224ed1799a46d5227f985301736cb97b57a464b10"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "524f1f8e4e0e980e4ab4cea0fe7eda272557f2e497752e0729cd026bd017502a"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.35/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "35f66eb831c81c0231eabbd0e0a9b3921a660e7dbc11b607cb7e94ef1cf73acd"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.35/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "86bf7231cf59e03be4a7b8a0e57f1a11832f5c8ebe9ca79db63cf1579eada311"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.35/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "62ebfce81f09fc15984f8c490b2c843507e77d86a576a2c20a5132981cac1f39"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.35/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "837511e050c425212b58805ae5eaee1dd1057aad4023b754220d5bb07410aa32"
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
