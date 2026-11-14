class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.36"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.36"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7600b716ad4c763d84c0b207401a86e8aa00252a4cca2277c585e0f169639049"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7600b716ad4c763d84c0b207401a86e8aa00252a4cca2277c585e0f169639049"
    sha256 cellar: :any_skip_relocation, big_sur: "c6d11bcef1e1e7da93da9cd93f6dec4051ad0dc075f4cdde8bca57e0d31ec99a"
    sha256 cellar: :any_skip_relocation, sequoia: "c6d11bcef1e1e7da93da9cd93f6dec4051ad0dc075f4cdde8bca57e0d31ec99a"
    sha256 cellar: :any_skip_relocation, arm64_linux: "a62f7a86f1caf7c9c3c450a8e3839345f009d39838ce8b6bb6e88100a980d2d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0923957aa0860857e800f007576c7adb4a0d3c6c5938910805f2075cfa87eb78"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.36/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "361b8d5272d1997a0a190d73666d756a080cd8da79af180e0a1d4bd6c6099f36"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.36/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "caa72d40bc357d5de496225b9c838e788e43e8980bddcdeb80d98582f502f782"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.36/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8ff5772891c08da788b959b4b47799f6ad4b3b27c9aef363ea0ddfdad55e7598"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.36/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0979f074cc50112284246d9a59699f4b4253413324f0c97cc749d42f4ac397eb"
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
