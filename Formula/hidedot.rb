class Hidedot < Formula
  desc "A dotfiles manager written in Go"
  homepage "https://github.com/youhide/hideDot"
  version "0.0.7"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.7/hideDot_Darwin_arm64.tar.gz"
      sha256 "c224f8426868ce226798032060df4decd4e491e5a3f805c46da63fc9c5e05019"
    end
    on_intel do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.7/hideDot_Darwin_x86_64.tar.gz"
      sha256 "6c391eb9377dc5c002065922a0df32222adc1e6a20abefc7725d9ed9e0b3b52d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.7/hideDot_Linux_arm64.tar.gz"
      sha256 "d592d53eaa3faac1daad6a940aa72b148dbea9285c63ab54f7e1542ca254225c"
    end
    on_intel do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.7/hideDot_Linux_x86_64.tar.gz"
      sha256 "2147d90e368c39aa781524e5a71a406e9b338845b51960914cc9d6befb3c87fc"
    end
  end

  def install
    bin.install "hidedot"
  end

  test do
    system "#{bin}/hidedot", "--version"
  end
end
