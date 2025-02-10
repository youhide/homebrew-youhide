# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hidedot < Formula
  desc "A dotfiles manager written in Go"
  homepage "https://github.com/youhide/hideDot"
  version "0.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/youhide/hideDot/releases/download/v0.0.3/hideDot_Darwin_x86_64.tar.gz"
      sha256 "abc8b80aa941e3d5acbc40a18054a1aa982faee526fd9f8634838b060a706b68"

      def install
        bin.install "hideDot" => "hidedot"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/youhide/hideDot/releases/download/v0.0.3/hideDot_Darwin_arm64.tar.gz"
      sha256 "e38bbbd7333339a891914799bcd3a1e508020895c132d89752960c1d2dcf2cac"

      def install
        bin.install "hideDot" => "hidedot"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/youhide/hideDot/releases/download/v0.0.3/hideDot_Linux_x86_64.tar.gz"
        sha256 "e29de7536cde2bc73d8adfd1062307b7f28439f8e81e972ceb5942e3965086a3"

        def install
          bin.install "hideDot" => "hidedot"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/youhide/hideDot/releases/download/v0.0.3/hideDot_Linux_arm64.tar.gz"
        sha256 "a3fc31b0e0d348cd8746e0e5e9359c2ddf49825cff6ad8abe316c417a3e6024d"

        def install
          bin.install "hideDot" => "hidedot"
        end
      end
    end
  end

  test do
    system "#{bin}/hidedot --help"
  end
end
