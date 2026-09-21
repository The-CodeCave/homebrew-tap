class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.14"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.14"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cbcf94fc678bd9bbc445480e6fef10123ac6f4faa58bf78290a74672a3239e83"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cbcf94fc678bd9bbc445480e6fef10123ac6f4faa58bf78290a74672a3239e83"
    sha256 cellar: :any_skip_relocation, big_sur: "3aacf5266aa3ae83d95cea50df70165ebc2ea871a3b59f85113fc56f07b924a3"
    sha256 cellar: :any_skip_relocation, sequoia: "3aacf5266aa3ae83d95cea50df70165ebc2ea871a3b59f85113fc56f07b924a3"
    sha256 cellar: :any_skip_relocation, arm64_linux: "954c28a1ce8c6d2910fbf7f74cda834e18e049d978f37f2b28f807114a7adb3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "66637facb35ae5c782c72ae5c147c9cec2b5175b64da537ced14642c4f9209d8"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.14/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "f2fbf3e8ef4ab9069f7c8d20e8a76bb018643e1158f97b61f76e16887e349b98"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.14/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "eb8c18d20d46ba6b059f3d7ed8e491d1065d2597c0462ec3094d79d1b717b4ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.14/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "62f10b339bfb4ea00c2610c79c014d5d62e07c93f11a641090bd3aa1944fbb6b"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.14/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0f944676dfb9dd87e563256c8ae3fd8a1da42eb2b715f7af0decd745d5890b0f"
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
