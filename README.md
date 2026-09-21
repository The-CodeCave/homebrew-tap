# The-CodeCave Homebrew tap

Install the Shipd CLI on macOS or Linux:

```sh
brew install The-CodeCave/tap/shipd
```

The formula is generated after every native release archive and Homebrew bottle passes its smoke tests. It uses immutable versioned URLs and per-platform SHA-256 checksums from `The-CodeCave/shipd-cli`.

Installation pours a prebuilt, Developer ID signed and Apple-notarized binary. No compiler, Xcode, or Command Line Tools are required, and Homebrew neither modifies nor re-signs the executable. If `brew` ever offers to build from source, run `brew update` first — an out-of-date tap checkout is the usual cause.

If `Formula/shipd.rb` is not present yet, the first CLI release has not been published and the install command is intentionally not active.
