class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.15"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.15"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0b5fb36cdb41c3018b2b10989de455ab58ebd309c9388756105808658405af17"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0b5fb36cdb41c3018b2b10989de455ab58ebd309c9388756105808658405af17"
    sha256 cellar: :any_skip_relocation, big_sur: "9658c5d04c0db85d98a4d937eadaf882baa8dc42eef64928d220b730d7a218c2"
    sha256 cellar: :any_skip_relocation, sequoia: "9658c5d04c0db85d98a4d937eadaf882baa8dc42eef64928d220b730d7a218c2"
    sha256 cellar: :any_skip_relocation, arm64_linux: "d52d08c94e53723fccf42149c56040015e747decf5dfef47302706814a121d03"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "25206288b6bbc0af027d1c651eeff8e6c08161335641109af36bdb49a13ff914"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.15/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "598f269af1d327e875bd54904e1193140d48e50cd3901b09e25ca90df06d6e85"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.15/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "e2065582cef764d46c13a4c0988bff8894992c638be9ae51c228ce8fab09363e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.15/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fefb1efbe79456f121c1161c7d65c632b6f2542ce2a48f90c366790474cac5e7"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.15/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d7c0e7d36017ba297dc2c209f2b6f93839affceaa76403663846604cef9ae101"
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
