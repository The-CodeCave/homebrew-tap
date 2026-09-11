class Shipd < Formula
  desc "CLI for the Shipd deployment control plane"
  homepage "https://github.com/The-CodeCave/shipd-cli"
  version "0.1.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.6/shipd-aarch64-apple-darwin.tar.gz"
      sha256 "d2f376b5bfc7e6fb50044f2ef45747d3b753cbeaae3cf392ce62bb7a5be0b27e"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.6/shipd-x86_64-apple-darwin.tar.gz"
      sha256 "7b1a3239e54dc3c8d0b105c47713b17c175b32ba3bc587ee358856d8ae74dbad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.6/shipd-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2793c93965595947e3990f84ecb47413ba62f550e9cc212e48bba78831fd3036"
    end
    on_intel do
      url "https://github.com/The-CodeCave/shipd-cli/releases/download/v0.1.6/shipd-x86_64-unknown-linux-musl.tar.gz"
      sha256 "939658d63cccdbbff5e201e211f0b2e4659a062845f3cb0281cbee3a3ea3ee53"
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
