cask "teach-me" do
  version "0.2.0"
  sha256 "11a70413f2fe71aba2ba59bf5f0abccf112d404d5685d64c31d1ee20ab5cd1b8"

  url "https://github.com/endorphin-ai/TEACH-ME/releases/download/teach-me-v#{version}/TeachMe-macos-universal.dmg"
  name "Teach Me"
  desc "Learn with Claude Code: tracked sessions, courses and a course hub"
  homepage "https://teach-me.software/"

  livecheck do
    url "https://github.com/endorphin-ai/TEACH-ME/releases"
    regex(/teach-me[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end

  depends_on macos: :monterey
  depends_on formula: ["git", "gh"]
  depends_on cask: ["claude-code"]

  app "TeachMe.app"

  zap trash: [
    "~/Library/Application Support/Teach Me",
    "~/Library/Preferences/com.endorphinailab.teachme.plist",
  ]
end
