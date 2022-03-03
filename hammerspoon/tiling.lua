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
  win:setFrame(f, 0)
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
  win:setFrame(f, 0)
end

function tileCenterFull()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end

-- method that tiles the currently focused window by
-- specifying a list of keypad numbers (e.g specifying 1, 4 and 7
-- tiles the current window to the left third of the screen on full
-- height)
function tileByKeypadNumbers(tileDefinition)
    local possibleKeypadNumbers = {
        { 7, 8, 9 },
        { 4, 5, 6 },
        { 1, 2, 3 },
    }

    local minRow = 0
    local maxRow = 0
    local minCol = 0
    local maxCol = 0

    for rowIndex, row in ipairs(possibleKeypadNumbers) do
        for colIndex, keypadNumber in ipairs(row) do
            for defIndex, v in ipairs(tileDefinition) do
                if v == keypadNumber then
                    if rowIndex < minRow or minRow == 0 then minRow = rowIndex end
                    if rowIndex > maxRow or maxRow == 0 then maxRow = rowIndex end
                    if colIndex < minCol or minCol == 0 then minCol = colIndex end
                    if colIndex > maxCol or maxCol == 0 then maxCol = colIndex end
                end
            end
        end
    end

    local topLeft = { x = 0, y = 0 }
    local bottomRight = { x = 0, y = 0 }
    topLeft.x = minCol
    topLeft.y = minRow
    bottomRight.x = maxCol
    bottomRight.y = maxRow
    return { topLeft, bottomRight }
end

Coord = {
    x = 0,
    y = 0
}

function tileByKeypadPositions(topLeft, bottomRight)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local xCoordinates = { max.x, max.x+max.w/3, max.x+max.w*2/3 }
  local yCoordinates = { max.y, max.y+max.h/3, max.y+max.h*2/3 }

  f.x = xCoordinates[topLeft.x]
  f.y = yCoordinates[topLeft.y]

  f.w = max.w / 3 * (bottomRight.x - topLeft.x + 1)
  f.h = max.h / 3 * (bottomRight.y - topLeft.y + 1)

  win:setFrame(f, 0)
end

function tileToLeftThirdFullHeight()
    local coords = tileByKeypadNumbers({1, 4, 7})
    print(coords[1].x, coords[1].y, coords[2].x, coords[2].y)
    tileByKeypadPositions(coords[1], coords[2])
end


function getWindowScreenIndex(window, screens, screenCount)
    local windowScreen = window:screen()
    for i = 1, screenCount do
        if screens[i] == windowScreen then
            return i
        end
    end
end

function tileXcodeAndSimulator() 
    local xCode = hs.application.find('Xcode')
    local simulator = hs.application.find('Simulator')

    local xCodeWindow = xCode:mainWindow()
    local xCodeFrame = xCodeWindow:frame()
    local screen = xCodeWindow:screen()
    local max = screen:frame()

    local simWindow = simulator:mainWindow()
    local simFrame = simWindow:frame()

    simFrame.x = max.x
    simFrame.y = max.y

    xCodeFrame.x = max.x + simFrame.w
    xCodeFrame.y = max.y
    xCodeFrame.w = max.w - simFrame.w
    xCodeFrame.h = max.h

    simWindow:setFrame(simFrame, 0)
    xCodeWindow:setFrame(xCodeFrame, 0)

    simulator:setFrontmost()
    xCode:activate()
end

function tileBrowserAndTerminal()
    local chrome = hs.application.find('Google Chrome')
    local iTerm = hs.application.find('iTerm')

    local chromeWindow = chrome:mainWindow()
    local chromeFrame = chromeWindow:frame()

    local iTermWindow = iTerm:mainWindow()
    local iTermFrame = iTermWindow:frame()
    local screen = iTermWindow:screen()
    local max = screen:frame()

    chromeFrame.x = max.x
    chromeFrame.y = max.y
    chromeFrame.w = max.w / 2
    chromeFrame.h = max.h

    iTermFrame.x = max.w / 2
    iTermFrame.y = max.y
    iTermFrame.w = max.w / 2
    iTermFrame.h = max.h

    chromeWindow:setFrame(chromeFrame, 0)
    iTermWindow:setFrame(iTermFrame, 0)

    chrome:setFrontmost()
    iTerm:activate()
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

local choices = {
    {
        ["text"] = "Xcode",
        ["subText"] = "Layout for Xcode and Simulator",
        ["uuid"] = "0"
    },
    {
        ["text"] = "Chrome and iTerm",
        ["subText"] = "Layout for development within the terminal",
        ["uuid"] = "1"
    }
}

function layoutChoiceCompletion(choice)
    if choice["uuid"] == "0" then
        tileXcodeAndSimulator()
    elseif choice["uuid"] == "1" then
        tileBrowserAndTerminal()
    end
end

function showLayoutChooser()
    local layoutChooser = hs.chooser.new(layoutChoiceCompletion)
    layoutChooser:choices(choices)
    layoutChooser:show()
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", tileRight)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", tileLeft)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "m", cycleFocusedWindow)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "0", tileCenterFull)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "x", tileXcodeAndSimulator)
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "l", showLayoutChooser)
