class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.38"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.38"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4a39d32e0449f28c405d50fbc93a0f6a1ca7b750c33ee37e9d0079a07996ad03"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4a39d32e0449f28c405d50fbc93a0f6a1ca7b750c33ee37e9d0079a07996ad03"
    sha256 cellar: :any_skip_relocation, big_sur: "59526bf83cb439152789017c5839f0511905c8b12c9202c47e05f3e55c390efc"
    sha256 cellar: :any_skip_relocation, sequoia: "59526bf83cb439152789017c5839f0511905c8b12c9202c47e05f3e55c390efc"
    sha256 cellar: :any_skip_relocation, arm64_linux: "b6d2d5bfe0d72e352ba2a000b4d9f70d6c037976ce32a6c02ad7c2fc3c45cbbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a56d1b8a36a5a4fa840736a1ab06e258719fe4df58627a5a837f6cc6670c42b"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.38/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "a3f072e0d3eeaa28794bcafabee47422aeeb3729a2307f17c686aa1a946310fc"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.38/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "92112b4bfb20ec830fd82717666394cd74786f6d3ad2513e77c0055c9e5bfb96"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.38/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4aa8aeb526f824831331c1efd04e7ed9f1cd232578b8927d976752542faca73f"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.38/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4a89d1b8d3d49e8218d1da057744c816141148e7b343541ce3c5afe81acc7c07"
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
