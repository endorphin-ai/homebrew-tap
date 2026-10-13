cask "lomi" do
  version "0.2.0"
  sha256 "6c779af262df820419f3c336c617fb1193d2f25ac4d8c58b054617dc18020639"

  url "https://github.com/endorphin-ai/hasbrains-agent-kit/releases/download/lomi-v#{version}/Lomi-macos-universal.zip"
  name "Lomi"
  desc "Claude Code usage in the menu bar"
  homepage "https://lomi.software/"

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
