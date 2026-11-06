class Monarch < Formula
  desc "An attention-first terminal multiplexer for AI coding agents"
  homepage "https://github.com/cooksterj/monarch"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.0/monarch-mux-aarch64-apple-darwin.tar.xz"
      sha256 "ec9b521a471bc093b56451b2341b23adf615df0e9f12078b8a2167d4bed6c1e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.0/monarch-mux-x86_64-apple-darwin.tar.xz"
      sha256 "16be16fc9d84752f0805abb12137401a2b2b5932a0f5cdf5d784dd1b28de6254"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.0/monarch-mux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c217b4aa629dd38e59da3da5d0eba90873ef19e8095532c9faab9aed91474d4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.0/monarch-mux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1a3ffd5faddd426614ac804c13650fd63a2a50406259715da14b9d6e1d356b2d"
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
