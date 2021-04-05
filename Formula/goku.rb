# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "watchexec"
  depends_on "candid82/brew/joker"
  # depends_on "https://raw.githubusercontent.com/candid82/homebrew-brew/2491ed79f9733e6d58b41eef0a771659a0eed162/joker.rb"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.3.11/goku.zip"
  sha256 "1f6eecd863f00c8caf7b41c32142b419badaf3b1f674cb6689bea75a543578fd"

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
        <string>/bin/sh</string>
        <string>-c</string>
        <string>exec -a gokuw #{Formula["watchexec"].opt_bin}/watchexec --restart --watch #{ENV["HOME"]}/.config/karabiner.edn #{opt_bin}/goku</string>
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
