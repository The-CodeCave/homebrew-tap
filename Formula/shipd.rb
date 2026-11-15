class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.39"
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
    root_url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.39"
    rebuild 0
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fcafd877829f10272f7ff55893512b8792110d52dd576d23875706ecc402618e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fcafd877829f10272f7ff55893512b8792110d52dd576d23875706ecc402618e"
    sha256 cellar: :any_skip_relocation, big_sur: "971880b93883ee58a6f261405bf0205e19fd36dbdef51ad028d492024d86713e"
    sha256 cellar: :any_skip_relocation, sequoia: "971880b93883ee58a6f261405bf0205e19fd36dbdef51ad028d492024d86713e"
    sha256 cellar: :any_skip_relocation, arm64_linux: "b3eeae87ccb62eb2b627b9771aa840a7b97a32618ccfbaa082a84dd6ec50c1eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9fe470c2bff482f8d4c1e37dee58ec9d6876029cdb0c5550bdba939a770bb5f7"
  end

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.39/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "5b1778555e7704cba790581752cd34439cff551cf6a921b8300cb4e5b5c4be0d"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.39/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "d7ac6e66df065ebe7994788d1778a79a57791fa96ad58695efe510ffcb64e3dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.39/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0f4d9aec963433b679cfc9882bb999a4a2926eba27dfb8813a2d1387c36f1e03"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.39/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c77527d163c9902b670f6ce9887ac6d256babc3778bd38909d6ee2d37612ed2a"
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
