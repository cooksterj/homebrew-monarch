class Monarch < Formula
  desc "An attention-first terminal multiplexer for AI coding agents"
  homepage "https://github.com/cooksterj/monarch"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.3/monarch-mux-aarch64-apple-darwin.tar.xz"
      sha256 "48cf09a8fbcc981245c6592b0a3efed18530a4950d7cc6205ceb68ed5d86f2a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.3/monarch-mux-x86_64-apple-darwin.tar.xz"
      sha256 "5b250a5ce48256cb8c2cd84c6c58826f205ab5ce2c9085eb8871a9e6000ac3df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.3/monarch-mux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "4b0fc3a07f2313e89e1e154ab7f5923289a8868b5433e137b8bddf1c3842106c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.3/monarch-mux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "24a98f8dc1379318668ee50e2ee8f05932ba5ea4868dc696ce496ec759869e3b"
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
