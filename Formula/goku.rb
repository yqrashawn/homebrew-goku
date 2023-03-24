# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "candid82/brew/joker"
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.6.0/goku.zip"
  sha256 "f07748c2da7347a3b65826cc60827a3c770cdbb5e66fee137391668e5d1d0014"

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
