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
  version "0.1.0"
  sha256 "6f79fe8353a96ab175651b214fd78b3c03a5de5ec459bd37389e35ba0494199f"

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
