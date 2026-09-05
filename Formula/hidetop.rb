class Hidetop < Formula
  desc "A modern terminal-based system monitor written in Go, offering real-time CPU, memory, Apple Silicon GPU metrics, energy impact, and an interactive process list."
  homepage "https://github.com/youhide/hideTop"
  version "0.0.9"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.9/hideTop_Darwin_arm64.tar.gz"
      sha256 "8edc6bea060109c3baa873202017408b8d3dd357faaecdedc9a6a8a88130efb2"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.9/hideTop_Darwin_x86_64.tar.gz"
      sha256 "31cc109898f3195d8be1a9b1d89d62a6a2cd7f926b52b4dd5ffa432d6d97c7c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.9/hideTop_Linux_arm64.tar.gz"
      sha256 "bfeeeeaab34cb19a9fbe7bb60a05590d43d54439f9501409875b4cdd77cee3b2"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.9/hideTop_Linux_x86_64.tar.gz"
      sha256 "00f3df46c509e4a38d5397200eff7c52b503989bfd56c6e982f7f791d75183af"
    end
  end

  def install
    bin.install "hidetop"
  end

  test do
    system "#{bin}/hidetop", "--version"
  end
end
