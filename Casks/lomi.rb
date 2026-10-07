cask "lomi" do
  version "0.1.3"
  sha256 "b7c9052ff8aa07ff5867524eeb52ed8342bab17e87a6f1234ac9bc45f1c093ca"

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
