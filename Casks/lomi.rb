cask "lomi" do
  version "0.1.2"
  sha256 "e89dfdaaf83a88323f85b8a9b60ff69d855c104919746c67e3bda3d86b0dbc4e"

  url "https://github.com/endorphin-ai/hasbrains-agent-kit/releases/download/lomi-v#{version}/Lomi-macos-universal.zip",
      verified: "github.com/endorphin-ai/hasbrains-agent-kit/"
  name "Lomi"
  desc "Claude Code usage in the menu bar"
  homepage "https://hasbrains.com/"

  livecheck do
    url "https://github.com/endorphin-ai/hasbrains-agent-kit/releases"
    regex(/lomi[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end

  depends_on formula: "jq"
  depends_on macos: :monterey

  app "Lomi.app"

  zap trash: [
    "~/.claude/lomi",
    "~/Library/Application Support/lomi",
  ]
end
