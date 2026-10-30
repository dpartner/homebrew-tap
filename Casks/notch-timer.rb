# Шаблон cask-файлу. Workflow release.yml підставляє версію, SHA256 і репозиторій
# та кладе результат у репозиторій <owner>/homebrew-tap → Casks/notch-timer.rb
cask "notch-timer" do
  version "1.1.2"
  sha256 "d4c880d7c75e73af6b937a979bd759b76b237d404035a5a0263a7b870931824b"

  url "https://github.com/dpartner/notch-timer/releases/download/v#{version}/NotchTimer.dmg"
  name "Notch Timer"
  desc "Boring Notch fork with a built-in time tracker"
  homepage "https://github.com/dpartner/notch-timer"

  depends_on macos: :sonoma

  app "Notch Timer.app"

  # Застосунок не нотаризований Apple — знімаємо карантин, щоб він відкривався без попередження.
  postflight_steps do
    run "xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Notch Timer.app"]
  end

  uninstall quit: "com.notchtimer.app"

  # Увага: `brew uninstall --zap` видалить і всі записи часу.
  zap trash: [
    "~/Library/Containers/com.notchtimer.app",
    "~/Library/Preferences/com.notchtimer.app.plist",
  ]
end
