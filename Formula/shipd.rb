class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.17"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.17"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e13da0ef8c10094328af7eb347b49fabe3a243415cc183fcfabb4fed8f0a1ab"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e13da0ef8c10094328af7eb347b49fabe3a243415cc183fcfabb4fed8f0a1ab"
    sha256 cellar: :any_skip_relocation, big_sur: "38505f918cd18b48a81c99cfebeac6fce0165ddd85c42c0833f370dfec040a70"
    sha256 cellar: :any_skip_relocation, sequoia: "38505f918cd18b48a81c99cfebeac6fce0165ddd85c42c0833f370dfec040a70"
    sha256 cellar: :any_skip_relocation, arm64_linux: "98016cec3e5ae7d4fc78cc6846b9e8ef64c19832c7621593726e36c7821d5140"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8831c11c884c87baef14ec14b119ece15a90753713029dea8b892519f9910fb"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.17/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "0c96da65eeeef7042a38d904490e9ac06a1c3974c77257ff6469e1c94b385e54"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.17/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "890d6588aa894f7d7b9b2b3315cb191d968f6f7ffced91a38be732d55d6c6a6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.17/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0f3d32138c1d9b0b9c4738b39a9f130fa169fc6199d9c2421dc8b8fac661cc47"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.17/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a23fba89793e3b835774937c3373f1006993cf16b15ef40176bdcc6ec3711cc5"
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
