class Hidepass < Formula
  desc "Pass-compatible password manager: same store, same gpg keys, more features"
  homepage "https://github.com/youhide/hidePass"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.1.0/hidepass_Darwin_arm64.tar.gz"
      sha256 "e741ce762b416ee3b58c616630783a20a450dc281366cbfd030a1fc90595757a"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.1.0/hidepass_Darwin_x86_64.tar.gz"
      sha256 "fe8b9030e39589858f169aeb0fdc6ab7519f1275f5ee70a06473a35e8b7c8c55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.1.0/hidepass_Linux_arm64.tar.gz"
      sha256 "80d4e5cddef4a3e935f70c23c1021b160b6021ba966ca825567aaa919b7648a1"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.1.0/hidepass_Linux_x86_64.tar.gz"
      sha256 "5d9108039eb21148505dc4f38dec986399bf9c61c880070c60aef542941e6fc2"
    end
  end

  def install
    bin.install "hidepass"
  end

  test do
    system "#{bin}/hidepass", "--version"
  end
end
