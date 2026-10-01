class Chainchaos < Formula
  desc "Blockchain-aware JSON-RPC chaos testing proxy for EVM applications"
  homepage "https://github.com/youhide/ChainChaos"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.2.0/chainchaos_Darwin_arm64.tar.gz"
      sha256 "b6368548ea2b751a91dda6044a538c6e2a4f5e8d782551d6d63508838a8dc70e"
    end
    on_intel do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.2.0/chainchaos_Darwin_x86_64.tar.gz"
      sha256 "82d3c873b33be724f94f18381e9b7e4302fd9361af2956e6d4a45e0709a4e0da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.2.0/chainchaos_Linux_arm64.tar.gz"
      sha256 "61b03ba651995956849d68bfbd72f114534b00b284f5463e13de7b23f45cd430"
    end
    on_intel do
      url "https://github.com/youhide/ChainChaos/releases/download/v0.2.0/chainchaos_Linux_x86_64.tar.gz"
      sha256 "dde35eeeadbe8c019f63ca9537efeefaae4f134d94797abbcc635559617c2b80"
    end
  end

  def install
    bin.install "chainchaos"
  end

  test do
    system "#{bin}/chainchaos", "--version"
  end
end
