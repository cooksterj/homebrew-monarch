class Monarch < Formula
  desc "An attention-first terminal multiplexer for AI coding agents"
  homepage "https://github.com/cooksterj/monarch"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.1/monarch-mux-aarch64-apple-darwin.tar.xz"
      sha256 "4a2261270b4491c66d6605ce921844a75237cc3c6a84246686d4571309f79cdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.1/monarch-mux-x86_64-apple-darwin.tar.xz"
      sha256 "be7994f2c4384604f3826f3f8078ae456160650532771ac7a85f49a7e5135534"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.1/monarch-mux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fdd7d8dd0d58b16a020698071e7ff1760e231638fc3272b904f9c0fc29532785"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.1/monarch-mux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4806e57a5ea29fa079372eb240253d5bb83cefac7c03b69e065eb67635b8c7e3"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "monarch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "monarch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "monarch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "monarch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
