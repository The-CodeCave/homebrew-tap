class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.29"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.29"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "21100f8ab8234fae86fea0ae3929367881608db2b6835762f14d809ba9fba095"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "21100f8ab8234fae86fea0ae3929367881608db2b6835762f14d809ba9fba095"
    sha256 cellar: :any_skip_relocation, big_sur: "a4b3d01042f36d87ff6fb2590e9b4fbf0badc8e30f7f67e4dddabd5796fe367f"
    sha256 cellar: :any_skip_relocation, sequoia: "a4b3d01042f36d87ff6fb2590e9b4fbf0badc8e30f7f67e4dddabd5796fe367f"
    sha256 cellar: :any_skip_relocation, arm64_linux: "41a7adfe7212528af9f274b2999f57cffa5aec21c2b41a978b18fa6b6219e268"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bfd44cbf5f77076a1e6a5e0d23c05eaddb7dda6b5a49cacc609c5632fb5e2537"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.29/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "7224719a525412b0cf916f0bdca806a523ba0233b641631baa5b8adecff2007f"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.29/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "646f3cc9f6b38ed118cecb8e3f9948e5c41d5d0b40b4a2f574dcde58be507dbc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.29/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d500e201233800ca6028da6a1fce54759840e4c305275fc6624a0450f8ed3a29"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.29/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ff307157781446054f2cf0a8932ff4db1b402e0e97f137053e135e8526665b17"
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
