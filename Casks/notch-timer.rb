# Шаблон cask-файлу. Workflow release.yml підставляє версію, SHA256 і репозиторій
# та кладе результат у репозиторій <owner>/homebrew-tap → Casks/notch-timer.rb
cask "notch-timer" do
  version "1.0.1"
  sha256 "85fdc641478008078020a066dae11b550a37288d54dd35e5acb0bfffb2b06c11"

  url "https://github.com/dpartner/notch-timer/releases/download/v#{version}/NotchTimer.dmg"
  name "Notch Timer"
  desc "Boring Notch fork with a built-in time tracker"
  homepage "https://github.com/dpartner/notch-timer"

  depends_on macos: ">= :sonoma"

  app "Notch Timer.app"

  # Застосунок не нотаризований Apple — знімаємо карантин, щоб він відкривався без попередження.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Notch Timer.app"]
  end

  uninstall quit: "com.notchtimer.app"

  # Увага: `brew uninstall --zap` видалить і всі записи часу.
  zap trash: [
    "~/Library/Containers/com.notchtimer.app",
    "~/Library/Preferences/com.notchtimer.app.plist",
  ]
end
