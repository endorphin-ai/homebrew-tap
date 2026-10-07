cask "lomi" do
  version "0.1.4"
  sha256 "2bce664a7ac174a4572bcc5c6c9a8c481019dfc64bd78d82a5a9cdfa9fb486fc"

  url "https://github.com/endorphin-ai/hasbrains-agent-kit/releases/download/lomi-v#{version}/Lomi-macos-universal.zip"
  name "Lomi"
  desc "Claude Code usage in the menu bar"
  homepage "https://hasbrains.com/"

  livecheck do
    url "https://github.com/endorphin-ai/hasbrains-agent-kit/releases"
    regex(/lomi[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end

  depends_on macos: :monterey

  app "Lomi.app"

  zap trash: [
    "~/.claude/lomi",
    "~/Library/Application Support/lomi",
  ]
end
