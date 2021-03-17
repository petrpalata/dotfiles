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

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", tileRight)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", tileLeft)
