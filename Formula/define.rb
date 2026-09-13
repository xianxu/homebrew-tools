class Define < Formula
  desc "Dictionary that remembers what you looked up, and asks you about it later"
  homepage "https://github.com/xianxu/tools"
  url "https://github.com/xianxu/tools/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "311dd9f7028f1caff5e0fcc23c32e6ccaf006d2036f5516507bd4b873afc428b"
  license "Apache-2.0"

  # macOS only, and not incidentally: definitions and IPA come from
  # Dictionary.app through CoreServices, and pronunciation plays with afplay.
  # Both are the platform's, which is also why this formula depends on nothing.
  depends_on :macos

  # Go is build-only. The binary it produces is static — no Go runtime at
  # execution time. First install pulls Go (~150 MB); later installs use the
  # cached toolchain.
  depends_on "go" => :build

  def install
    ENV["GOFLAGS"] = "-trimpath -mod=readonly"
    # The version is stamped HERE rather than kept in a constant in the source:
    # the tag and the formula are the two things that already have to agree for
    # a release to exist, so binding it to them removes the third place that
    # could drift. `define --version` on a build from a clone says "built from
    # source" instead of a number it cannot justify.
    system "go", "build", "-ldflags", "-X main.version=v#{version}",
           "-o", bin/"define", "./cmd/define"
  end

  test do
    # The version the formula stamped, read back off the binary — this catches a
    # broken ldflags path, which otherwise fails silently as "built from source".
    assert_match "define v#{version}", shell_output("#{bin}/define --version")

    # And it runs with no deck, no network and no configuration: a directory
    # with nothing in it is the state every new install is in, and --stats is
    # the one command that reports on emptiness rather than refusing.
    output = shell_output("#{bin}/define --stats 2>&1")
    assert_match "Nothing yet", output
  end
end
