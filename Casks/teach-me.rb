cask "teach-me" do
  version "0.2.1"
  sha256 "9c6bbad7b7b076b3dbdf974f8deb3196234343395c3f859d5decf473525e5709"

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
