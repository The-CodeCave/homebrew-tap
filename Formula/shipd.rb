class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.12"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.12/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "4864981ad374a0e2d5494c994c05f9f054381956b30aafe8dfc3a6f40098e26d"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.12/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "9cb1d4d3a20fbe3bec62855c4ae8c2111f8a9b19cae0a1662c26284f8cc92be9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.12/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b50ca0cda1ec8aeba3785b562ec72174de7f93e025dcf2aaa0304adb4500c291"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.12/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f7ac91e9de1834b5c063886cc7b4effdad2bf9870ba6a1887d87d78f6e4538d1"
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
