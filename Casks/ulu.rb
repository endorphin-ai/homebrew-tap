# Homebrew cask for ULU, in the tap endorphin-ai/homebrew-tap (next to Casks/lomi.rb).
#
#   brew install --cask endorphin-ai/tap/ulu
#
# Installs what ULU's teams need along with the app: git, the GitHub CLI and
# Node.js (formulas), and Claude Code and Ollama (casks) when the Mac does not
# have them already. On first start ULU downloads the search model
# (nomic-embed-text, about 270 MB) through Ollama, with its progress in the
# window, and asks the person to sign in to Claude and GitHub where needed.
cask "ulu" do
  version "0.6.0"
  sha256 "156ba2509114d30171b3772077d08b8916a21d0f79cc62f093dfc8d9692e2ae3"

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
  # Claude Code and Ollama too, unless this Mac has them already from their
  # own installers: brew would put a second Claude next to the first, and it
  # refuses to install Ollama.app over the one from ollama.com, which would
  # stop the whole install. (A copy Homebrew itself installed is seen by
  # brew as the dependency met.)
  home = Dir.home
  claude_there = ["#{home}/.local/bin/claude", "#{home}/.claude/local/claude",
                  "/usr/local/bin/claude", "/opt/homebrew/bin/claude"].any? { |p| File.executable?(p) }
  ollama_there = File.directory?("/Applications/Ollama.app") || File.directory?("#{home}/Applications/Ollama.app") ||
                 File.executable?("/opt/homebrew/bin/ollama") || File.executable?("/usr/local/bin/ollama")
  depends_on cask: "claude-code" unless claude_there
  depends_on cask: "ollama-app" unless ollama_there

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
