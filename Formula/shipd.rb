class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.37"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.37"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3b95ef7b39257a85032a34ddf91fc85c6b953afa06ebdb7fd4e86068a6464aeb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3b95ef7b39257a85032a34ddf91fc85c6b953afa06ebdb7fd4e86068a6464aeb"
    sha256 cellar: :any_skip_relocation, big_sur: "cb861d4ea7f1669d8a511a7abbb573a28be0ebc3a1982755eac8a8687df128c3"
    sha256 cellar: :any_skip_relocation, sequoia: "cb861d4ea7f1669d8a511a7abbb573a28be0ebc3a1982755eac8a8687df128c3"
    sha256 cellar: :any_skip_relocation, arm64_linux: "ee72a8fbd427ecbd47b9ee1e242e3e56d0750c47e8c298222ef9d44acbdaf721"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "00c0d481522e368259e21f1eebad587ce7836bccbedf285f53e6c187afdf0c28"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.37/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "98ce19fe16568d5d372484803b4c623d73d3d82c9c7df9c3b8ba75f430fcf520"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.37/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "25c61184179244a7126b538b71af57242d7fe21798438720ff0e13ec9277ff95"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.37/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "54a879a3f0da9204069c521fdace26e29e0f80b0d4c5b197e0e4e84381c5fce8"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.37/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5bc5e8db51d23913805a5c9bfd7b9dc1e07ae71f39bbf73020e79512cdf82e11"
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
