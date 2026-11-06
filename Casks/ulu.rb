# Homebrew cask for ULU, in the tap endorphin-ai/homebrew-tap (next to Casks/lomi.rb).
#
#   brew install --cask endorphin-ai/tap/ulu
#
# Installs what ULU's teams need along with the app: git, the GitHub CLI and
# Node.js (formulas), Claude Code and Ollama (casks). On first start ULU
# downloads the search model (nomic-embed-text, about 270 MB) through Ollama,
# with its progress in the window, and asks the person to sign in to Claude
# and GitHub where needed.
cask "ulu" do
  version "0.5.7"
  sha256 "b879752f340d61130d5efed8e3d2655a4f28f0a2e7f0fe902631dcb3b4faebcf"

  url "https://github.com/endorphin-ai/ulu-releases/releases/download/ulu-v#{version}/ULU-macos-universal.zip"
  name "ULU"
  desc "AI agents beehive: design, build and run Claude Code agent teams"
  homepage "https://ulu.software/"

  livecheck do
    url "https://github.com/endorphin-ai/ulu-releases/releases"
    regex(/ulu[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end

  depends_on macos: :monterey
  depends_on formula: ["git", "gh", "node"]
  depends_on cask: ["claude-code", "ollama-app"]

  app "ULU.app"


  caveats <<~EOS
    Start Ollama once (ULU's Tools has a button), so Ask can search by meaning.
    On first start ULU downloads the search model for Ask (about 270 MB)
    and asks you to sign in to Claude Code and GitHub if you have not.
  EOS

  zap trash: [
    "~/Library/Application Support/squad-architect",
    "~/Library/Preferences/com.endorphinailab.ulu.plist",
  ]
end
