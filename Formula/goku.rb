# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "joker"
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"

  if Hardware::CPU.arm?
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.1/goku-arm.zip"
    sha256 "f5a129f6b8afa138fdc32e674bb8e964ac064cf038a4b96d7d6b267becbf65ec"
  else
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.1/goku.zip"
    sha256 "e6344a247bd001fb0dd8caad5da8c545211f79d5b6fa5c169b23e96540388a1e"
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
