function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        hs.alert.show("Config reloaded")
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = 0
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

function countScreens(screens)
    local count = 0
    for _ in pairs(screens) do
        count = count + 1
    end
    return count
end

local hyperModifier = {"cmd", "alt", "ctrl", "shift"}

-- flip screens
hs.hotkey.bind(hyperModifier, "r", function()
    local screens = hs.screen.allScreens()
    local screenCount = countScreens(screens)
    if screenCount == 3 then
        local landscapeScreen = hs.screen('1920x1080')
        local portraitScreen = hs.screen('1080x1920')
        local laptopScreen = hs.screen("Color LCD")

        portraitScreen:setPrimary()
        portraitScreen:rotate(0)
        landscapeScreen:rotate(270)
        landscapeScreen:setOrigin(-1080, 0)
        laptopScreen:setOrigin(0, 1080)
    end
end)

function bindAppToHyper(appName, hotkey)
    hs.hotkey.bind(hyperModifier, hotkey, function() 
        local app = hs.application.find(appName)
        app:activate()
    end)
end

bindAppToHyper("Google Chrome", "b")
bindAppToHyper("iTerm2", "t")
bindAppToHyper("Bear", "d")
bindAppToHyper("Code", "v")
bindAppToHyper("Slack", "s")
bindAppToHyper("Xcode", "x")

hs.hotkey.bind(hyperModifier, "b", function()
    hs.urlevent.openURL(string.format("bear://x-callback-url/open-note?title=%s", os.date("%d/%m/%Y")))
end)
