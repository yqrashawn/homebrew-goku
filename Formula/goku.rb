# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Goku < Formula
  depends_on "candid82/brew/joker"
  # depends_on "https://raw.githubusercontent.com/candid82/homebrew-brew/2491ed79f9733e6d58b41eef0a771659a0eed162/joker.rb"
  desc "karabiner configurator"
  homepage "https://github.com/yqrashawn/GokuRakuJoudo"
  url "https://github.com/yqrashawn/GokuRakuJoudo/releases/download/v0.6.0/goku.zip"
  sha256 "f07748c2da7347a3b65826cc60827a3c770cdbb5e66fee137391668e5d1d0014"

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
        <string>#{opt_bin}/goku</string>
      </array>
      <key>WatchPaths</key>
      <array>
          <string>#{ENV["HOME"]}/.config/karabiner.edn</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
          <key>GOKU_EDN_CONFIG_FILE</key>
          <string>#{ENV["HOME"]}/.config/karabiner.edn</string>
      </dict>
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
