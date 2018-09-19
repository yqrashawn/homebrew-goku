# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "watchexec"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.1.7/goku.tar.gz"
  sha256 "3cd9572095f7a375b365bb9410834383457546b17687c729b03d170edde42107"

  def install
    system "mkdir", "-p", "#{ENV['HOME']}/Library/Logs/goku/"
    system "chmod", "+x", "gokuw"
    bin.install "goku"
    bin.install "gokuw"
  end

  plist_options :manual => "gokuw"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/opt/watchexec/bin/watchexec</string>
        <string>--restart</string>
        <string>--watch</string>
        <string>#{ENV["HOME"]}/.config/karabiner.edn</string>
        <string>/usr/local/opt/goku/bin/goku</string>
      </array>
      <key>StandardErrorPath</key>
      <string>#{ENV["HOME"]}/Library/Logs/goku/error.log</string>
      <key>StandardOutPath</key>
      <string>#{ENV["HOME"]}/Library/Logs/goku/output.log</string>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/goku", "--help"
  end
end