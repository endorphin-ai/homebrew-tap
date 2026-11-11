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
  version "0.8.13"
  sha256 "c38439c5a0625b60449c90728c35157f727136ae345b15269b88417102ac3ffe"

  url "https://github.com/endorphin-ai/ulu-releases/releases/download/ulu-v#{version}/ULU-macos-universal.zip"
  name "ULU"
  desc "AI agents beehive: design, build and run Claude Code agent teams"
  homepage "https://ulu.software/"

  livecheck do
    url "https://github.com/endorphin-ai/ulu-releases/releases"
    regex(/ulu[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :page_match
  end

  # Claude Code and Ollama too, unless this Mac has them already from their
  # own installers: brew would put a second Claude next to the first, and it
  # refuses to install Ollama.app over the one from ollama.com, which would
  # stop the whole install. (A copy Homebrew itself installed is seen by
  # brew as the dependency met.)
  home = Dir.home
  # The places ULU itself looks for Claude Code: its installer, Homebrew, npm
  # (its global folder, nvm, volta, fnm, pnpm, yarn) and bun.
  claude_places = ["#{home}/.local/bin", "#{home}/.claude/local", "/usr/local/bin", "/opt/homebrew/bin",
                   "#{home}/.npm-global/bin", "#{home}/.npm-packages/bin", "#{home}/.volta/bin",
                   "#{home}/.bun/bin", "#{home}/Library/pnpm", "#{home}/.yarn/bin", "#{home}/bin"] +
                  Dir.glob("#{home}/.nvm/versions/node/*/bin") +
                  Dir.glob("#{home}/.local/share/fnm/node-versions/*/installation/bin") +
                  Dir.glob("#{home}/Library/Application Support/fnm/node-versions/*/installation/bin")
  claude_there = claude_places.any? { |d| File.executable?("#{d}/claude") }
  ollama_there = File.directory?("/Applications/Ollama.app") || File.directory?("#{home}/Applications/Ollama.app") ||
                 File.executable?("/opt/homebrew/bin/ollama") || File.executable?("/usr/local/bin/ollama")

  depends_on formula: ["git", "gh", "node"]
  depends_on macos: :monterey

  depends_on cask: "claude-code" unless claude_there
  depends_on cask: "ollama-app" unless ollama_there

  app "ULU.app"
  binary "#{appdir}/ULU.app/Contents/MacOS/ulu"

  zap trash: [
    "~/Library/Application Support/squad-architect",
    "~/Library/Preferences/com.endorphinailab.ulu.plist",
  ]

  caveats <<~EOS
    Start Ollama once (ULU's Tools has a button), so Ask can search by meaning.
    On first start ULU downloads the search model for Ask (about 270 MB)
    and asks you to sign in to Claude Code and GitHub if you have not.
  EOS
end
