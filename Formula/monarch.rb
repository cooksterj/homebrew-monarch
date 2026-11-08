class Monarch < Formula
  desc "An attention-first terminal multiplexer for AI coding agents"
  homepage "https://github.com/cooksterj/monarch"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.2/monarch-mux-aarch64-apple-darwin.tar.xz"
      sha256 "5f664da206aace47dd354c99fcc015b002a1f20f54e285bb619abb89ecf5362a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.2/monarch-mux-x86_64-apple-darwin.tar.xz"
      sha256 "77b5e7291902e5f851373e0efa3382b653d0bcae165905b0a7df7a0981ec8755"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.2/monarch-mux-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1829d6cbd8aa8c63d6d50069f1f002d0639cbf68b1a4b6aef904dc31cd9e5845"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cooksterj/monarch/releases/download/v0.1.2/monarch-mux-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0e11cac050adaa537384d10ba7dadea1beb2f1d3018ab424b06cb6b36cad3760"
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
