# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "watchexec"
  depends_on "candid82/brew/joker"
  # depends_on "https://raw.githubusercontent.com/candid82/homebrew-brew/2491ed79f9733e6d58b41eef0a771659a0eed162/joker.rb"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.3.6/goku.tar.gz"
  sha256 "519def2a0a52a9dad434b9c2a5c85351694966bba0cc68bdbb1f2faac50c5adf"

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
