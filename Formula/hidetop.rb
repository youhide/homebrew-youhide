class Hidetop < Formula
  desc "A modern terminal-based system monitor written in Go, offering real-time CPU, memory, Apple Silicon GPU metrics, energy impact, and an interactive process list."
  homepage "https://github.com/youhide/hideTop"
  version "0.0.7"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.7/hideTop_Darwin_arm64.tar.gz"
      sha256 "adbfb16ee46752aab22b208689600f70b348089460cd71b9bad0eecb718f4d06"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.7/hideTop_Darwin_x86_64.tar.gz"
      sha256 "32abdcc4511015655b0618a73633a7060ab21257e869fdb3f23fb6044ef12c66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.7/hideTop_Linux_arm64.tar.gz"
      sha256 "d9559f49138ef9aa60d3100ccd24851dab862eb24c2c002637fed5837e89390b"
    end
    on_intel do
      url "https://github.com/youhide/hideTop/releases/download/v0.0.7/hideTop_Linux_x86_64.tar.gz"
      sha256 "f3396dc64d34dc253fcf9426d550bb666920458fb149a32188e1ef0c2d934215"
    end
  end

  def install
    bin.install "hidetop"
  end

  test do
    system "#{bin}/hidetop", "--version"
  end
end
