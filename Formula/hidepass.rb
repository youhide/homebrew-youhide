class Hidepass < Formula
  desc "Pass-compatible password manager: same store, same gpg keys, more features"
  homepage "https://github.com/youhide/hidePass"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.2.0/hidepass_Darwin_arm64.tar.gz"
      sha256 "b7afa4405e8e17e3295fafef22006a4f610f9be0363374d60eb485563cff2698"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.2.0/hidepass_Darwin_x86_64.tar.gz"
      sha256 "75bf0d96bad09721fdb982c5e4209fce48013106ecd863575e5accb064cc2da8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/youhide/hidePass/releases/download/v0.2.0/hidepass_Linux_arm64.tar.gz"
      sha256 "2129dce4fea4dc6f867d07f808a8160b30fd1c148c7d2d9770cb89ca1ee4f83f"
    end
    on_intel do
      url "https://github.com/youhide/hidePass/releases/download/v0.2.0/hidepass_Linux_x86_64.tar.gz"
      sha256 "f6e362c6b6f09a8bf197866e1aca31ab0dcef475e8e713826e668f9e102e5238"
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
