# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "joker"
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.0/goku.zip"
  sha256 "45dc037474ef290cf413a38c586fbf32ba80421d28a6c23a7224444b44166812"

  if Hardware::CPU.arm?
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.0/goku-arm.zip"
    sha256 "1e3392866e232b1ff5e2b61cc65f2961247f71e4f8f7b2de234b71835371bea5"
  else
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.0/goku.zip"
    sha256 "45dc037474ef290cf413a38c586fbf32ba80421d28a6c23a7224444b44166812"
  end

  def install
    bin.install "goku"
    bin.install "gokuw"
  end

  service do
    run "#{opt_bin}/gokuw"
    environment_variables PATH: std_service_path_env
    keep_alive true
    run_at_load true
    log_path "#{ENV["HOME"]}/Library/Logs/goku.log"
    error_log_path "#{ENV["HOME"]}/Library/Logs/goku.log"
  end

  test do
    system "#{bin}/goku", "--help"
  end
end
