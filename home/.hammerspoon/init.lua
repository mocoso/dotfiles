-- Windows
hs.hotkey.bind({"alt", "ctrl"}, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "M", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + max.h / 2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, ",", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + max.h / 2
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, ".", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y + max.h / 2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)
-- End of windows

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "M", function()
  local clockWidth = 250
  setUpChatClock(clockWidth)

  hs.application.launchOrFocus("Google Chrome Monkeys Thumb")

  local chrome = hs.window.focusedWindow():application()
  chrome:selectMenuItem({"File", "New Window"});

  local win = hs.window.focusedWindow()
  positionChatWindow(clockWidth, win)
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Z", function()
  local clockWidth = 250
  setUpChatClock(clockWidth)

  local win = hs.window.find("Zoom Meeting")

  if (win ~= nil)
    then
    positionChatWindow(clockWidth, win)
  else
  hs.alert.show("Open the Zoom Meeting first")
  end
end)

function setUpChatClock(clockWidth)
  hs.application.launchOrFocus("Smart Countdown Timer")
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = clockWidth
  win:setFrame(f)
end

function positionChatWindow(clockWidth, win)
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (clockWidth * 5 / 8)
  f.y = max.y
  f.w = max.w - (clockWidth * 5 / 8)
  f.h = max.h / 2
  win:setFrame(f)
end
