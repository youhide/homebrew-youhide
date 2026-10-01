class Oxinit < Formula
  desc "Service manager and PID 1 for Linux"
  homepage "https://github.com/youhide/oxinit"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on :linux

  on_arm do
    url "https://github.com/youhide/oxinit/releases/download/v0.1.0/oxinit-v0.1.0-aarch64-linux-musl.tar.gz"
    sha256 "d7750e8778130312dec7da1a1b7a3ba986aeb1011d316cd14b81853804cbe3e9"
  end
  on_intel do
    url "https://github.com/youhide/oxinit/releases/download/v0.1.0/oxinit-v0.1.0-x86_64-linux-musl.tar.gz"
    sha256 "69206038669562470ce83ed222bf7828036a615354aaf69e5d2f7af7f18bdb67"
  end

  def install
    bin.install "oxinit", "oxctl", "oxlogd"
    doc.install "UNIT_FORMAT.md"
  end

  test do
    system "#{bin}/oxinit", "--version"
    system "#{bin}/oxctl", "--version"
    system "#{bin}/oxlogd", "--version"
  end
end
