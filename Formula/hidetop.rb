class Hidetop < Formula
  desc "A modern terminal-based system monitor written in Go, offering real-time CPU, memory, Apple Silicon GPU metrics, energy impact, and an interactive process list."
  homepage "https://github.com/youhide/hideTop"
  version "0.0.8"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.8/hideTop_Darwin_arm64.tar.gz"
      sha256 "29cb95cec97dd32ea59a87bc2635ff5b78fc6d151914d74d45cd542b03327f5f"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.8/hideTop_Darwin_x86_64.tar.gz"
      sha256 "0f76eb52a955c794f5fa70a1a6c27927557d571b623f7e404339f15206b95ae8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.8/hideTop_Linux_arm64.tar.gz"
      sha256 "622915cff06f8800399034872f61174d72a321a24829e495a450b14372e9f8a2"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.8/hideTop_Linux_x86_64.tar.gz"
      sha256 "eb6c2c85aabbffd92912fa5fe61ebd87c5b364a999d1fa4e4e17d94982f83dbe"
    end
  end

  def install
    bin.install "hidetop"
  end

  test do
    system "#{bin}/hidetop", "--version"
  end
end
