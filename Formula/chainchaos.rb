class Chainchaos < Formula
  desc "Blockchain-aware JSON-RPC chaos testing proxy for EVM applications"
  homepage "https://github.com/youhide/ChainChaos"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.1.0/chainchaos_Darwin_arm64.tar.gz"
      sha256 "3fb445e95505f1286c8be654971d774427bf621ff642b3084d0a9467214d4b66"
    end
    on_intel do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.1.0/chainchaos_Darwin_x86_64.tar.gz"
      sha256 "0a7e600a22dd5c8c79000c363e5e36fba9aa3085165a36f24053f0bbfd2f47ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.1.0/chainchaos_Linux_arm64.tar.gz"
      sha256 "0f2da1fb5ff11a8935df2849c8d53a8449ba2d2f0c99fa721d1a3d61a444573b"
    end
    on_intel do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.1.0/chainchaos_Linux_x86_64.tar.gz"
      sha256 "50a1e726673cc0afb75ac7f007fa247ba866ad2297050dd6562372b03a84d1c9"
    end
  end

  def install
    bin.install "chainchaos"
  end

  test do
    system "#{bin}/chainchaos", "--version"
  end
end
