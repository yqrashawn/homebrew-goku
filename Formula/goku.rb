# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "watchexec"
  depends_on "candid82/brew/joker"
  # depends_on "https://raw.githubusercontent.com/candid82/homebrew-brew/2491ed79f9733e6d58b41eef0a771659a0eed162/joker.rb"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.2.0/goku.tar.gz"
  sha256 "1f4c0255743ee0a4f99cd89f8f5bb5490febc3d6575355bb3dccf87c1133afb3"

  def install
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
      <string>#{ENV["HOME"]}/Library/Logs/goku.log</string>
      <key>StandardOutPath</key>
      <string>#{ENV["HOME"]}/Library/Logs/goku.log</string>
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