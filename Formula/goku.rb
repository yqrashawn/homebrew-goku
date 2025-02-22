# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "joker"
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"

  if Hardware::CPU.arm?
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.8.0/goku-arm.zip"
    sha256 "c912f151f01067eac4effe36c278e5b3a5274febdbfdbe58de5556ba36461008"
  else
    url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.8.0/goku.zip"
    sha256 "85b93b405d244de05ca2de0e155ff285539457f3a9138e1dffb9e87dda018a98"
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
