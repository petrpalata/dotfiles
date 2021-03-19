require("hotkeys")

function tileRight()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function tileLeft()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function getWindowScreenIndex(window, screens, screenCount)
    local windowScreen = window:screen()
    for i = 1, screenCount do
        if screens[i] == windowScreen then
            return i
        end
    end
end

function cycleFocusedWindow()
    local screens = hs.screen.allScreens()
    local screenCount = countScreens(screens)

    local focusedWindow = hs.window.focusedWindow()
    local focusedWindowScreenIndex = getWindowScreenIndex(focusedWindow, screens, screenCount)

    local targetScreenIndex = focusedWindowScreenIndex % screenCount + 1
    local targetScreen = screens[targetScreenIndex]

    focusedWindow:moveToScreen(targetScreen, true, true, 0)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", tileRight)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", tileLeft)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "m", cycleFocusedWindow)
