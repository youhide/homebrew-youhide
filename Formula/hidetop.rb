class Hidetop < Formula
  desc "A modern terminal-based system monitor written in Go, offering real-time CPU, memory, Apple Silicon GPU metrics, energy impact, and an interactive process list."
  homepage "https://github.com/youhide/hideTop"
  version "0.0.10"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.10/hideTop_Darwin_arm64.tar.gz"
      sha256 "52cfd6f2687de1769d58224218fa9b73a965c2e79db472628fdc269c7531655c"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.10/hideTop_Darwin_x86_64.tar.gz"
      sha256 "9e703e5cd358b3d73b3cd907a379e0fb50a4901820bb53e5ba44e148c32454e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.10/hideTop_Linux_arm64.tar.gz"
      sha256 "99169b702da7506fa5dfbbe0c973bb2446f40537509b01833a5b86c7cca7248b"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.10/hideTop_Linux_x86_64.tar.gz"
      sha256 "35cca44fb7006534f3dae15b0ba47e489083ae047ea1c0cf4eac6c252db60693"
    end
  end

  def install
    bin.install "hidetop"
  end

  test do
    system "#{bin}/hidetop", "--version"
  end
end
