cask "lomi" do
  version "0.1.1"
  sha256 "e32dd39e5f735f14a4a2e0dc142620ff799616ed794c909f112bff62bbbf4f8a"

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
