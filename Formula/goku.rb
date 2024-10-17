# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "joker"
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"

  if Hardware::CPU.arm?
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.2/goku-arm.zip"
    sha256 "9a3cf5243d76536dcf8bc92e9842ed4fd10d857a57f036f82d44b70ceb4fe463"
  else
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.7.2/goku.zip"
    sha256 "0856bc8b866654a1f98cda790fcaef8dac8b8f720d962c169a726d285eb28018"
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
