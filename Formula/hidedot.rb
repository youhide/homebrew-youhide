class Hidedot < Formula
  desc "A dotfiles manager written in Go"
  homepage "https://github.com/youhide/hideDot"
  version "0.0.8"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.8/hideDot_Darwin_arm64.tar.gz"
      sha256 "26b6d65b5fc6dd0e305c652bf95b2bc468a245a5ff7dd5399bfe5297c4f91b45"
    end
    on_intel do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.8/hideDot_Darwin_x86_64.tar.gz"
      sha256 "6c1dfede97139704f1206b29453b9bd5dd5f5a0ed4705fbab6760d2972d0cbd2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.8/hideDot_Linux_arm64.tar.gz"
      sha256 "a6cede0673a9779694f269bbff58238804a66827091ab8906647e15f145aabd3"
    end
    on_intel do
      url "https://github.com/youhide/hideDot/releases/download/v0.0.8/hideDot_Linux_x86_64.tar.gz"
      sha256 "2a805bf1d13e470c4531c74f0c85f89a497b5fbc9343cb71aebb6a0af6ad138c"
    end
  end

  def install
    bin.install "hidedot"
  end

  test do
    system "#{bin}/hidedot", "--version"
  end
end
