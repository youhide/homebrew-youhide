# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Hidedot < Formula
  desc "A dotfiles manager written in Go"
  homepage "https://github.com/youhide/hideDot"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/youhide/hideDot/releases/download/v0.0.4/hideDot_Darwin_x86_64.tar.gz"
      sha256 "020e74620ab663929bea63c350f3d85e31154143b5d709078d58c27b7b65659a"

      def install
        bin.install "hideDot" => "hidedot"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/youhide/hideDot/releases/download/v0.0.4/hideDot_Darwin_arm64.tar.gz"
      sha256 "985131349502c130d0d451271ead7c338862b1171c1771f3d7eb37346f59510f"

      def install
        bin.install "hideDot" => "hidedot"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/youhide/hideDot/releases/download/v0.0.4/hideDot_Linux_x86_64.tar.gz"
        sha256 "48615bc18d843b719b552b82270c8331b45e1b6d2b539fb363316a1a2c1338f0"

        def install
          bin.install "hideDot" => "hidedot"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/youhide/hideDot/releases/download/v0.0.4/hideDot_Linux_arm64.tar.gz"
        sha256 "d92eee08080f351057e14e4d260b8b65680383f5f1f2915fc2bf83416139920a"

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
