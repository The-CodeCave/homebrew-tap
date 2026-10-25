class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.26"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.26"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "90e935eca372fb98aa02267afd15f91c721d524dffd3bdcded43318b83f87386"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "90e935eca372fb98aa02267afd15f91c721d524dffd3bdcded43318b83f87386"
    sha256 cellar: :any_skip_relocation, big_sur: "5d684e620bf12192eb1667f01b0f2dea182bd5fd9dbd7eb8721a5c2acaa4b90c"
    sha256 cellar: :any_skip_relocation, sequoia: "5d684e620bf12192eb1667f01b0f2dea182bd5fd9dbd7eb8721a5c2acaa4b90c"
    sha256 cellar: :any_skip_relocation, arm64_linux: "6f32e1fd0f0ac1fcff17ccd378ec2c32bbaa7433e95e2754bda40fb09fd6f2e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab712535a0d4a2d319d72066bbccf076520d9f556d5f145868f96605b9d1a288"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.26/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "5ec5b86312b00c3c4572c19b0d796c4d05ddd400d32252d9a2c3245aa4e132be"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.26/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "fc7c010afc60d45fdcc73f06fc802e0a6f8cf3f1e305651ec033413570ccb752"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.26/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "34791c097764b28b499e3897b5c74d9676d74b07d2c79c76f828de6873cadbf0"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.26/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a3337a29e0df2fd7572041354df38ff506f8606e45f7a88616db68bf580b5768"
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
