class Hidepass < Formula
  desc "Pass-compatible password manager: same store, same gpg keys, more features"
  homepage "https://github.com/youhide/hidePass"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.3.0/hidepass_Darwin_arm64.tar.gz"
      sha256 "50d6164c6c2248b57b771338648e492059be8bdeaf54feb81dd0d13d69688ff4"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.3.0/hidepass_Darwin_x86_64.tar.gz"
      sha256 "2fc98eecd6172468048214152d20415bf160fd6f5a17b504e3d26d004272d531"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.3.0/hidepass_Linux_arm64.tar.gz"
      sha256 "8e9bcb7081981de0a0ab11e74cacb8dd1b43bef5f87b82db733cd189c81e0117"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.3.0/hidepass_Linux_x86_64.tar.gz"
      sha256 "bcc98a7a4b3689993c95f39cd947772b2be3e54cb124f43cd57e82a8d648fcb9"
    end
  end

  def install
    bin.install "hidepass"
    generate_completions_from_executable(bin/"hidepass", "completions")
  end

  test do
    system "#{bin}/hidepass", "--version"
  end
end
