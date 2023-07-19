-- Windows
hs.hotkey.bind({"alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + clockOffset(screen)
  f.y = max.y
  f.w = (max.w / 2) - clockOffset(screen)
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + clockOffset(screen)
  f.y = max.y / 2
  f.w = max.w - clockOffset(screen)
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "O", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + clockOffset(screen)
  f.y = max.y
  f.w = (max.w /2) - clockOffset(screen)
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + clockOffset(screen)
  f.y = max.y
  f.w = max.w - clockOffset(screen)
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

-- Video call

CLOCK_WIDTH = 250
CLOCK_APP_BUNDLE_ID = "com.fiplab.smartcountdowntimer"
OBS_APP_BUNDLE_ID = "com.obsproject.obs-studio"

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "G", function()
  setDefaultAudioDevices()
  setUpVideo("Google");
  setUpChatClock()

  hs.application.launchOrFocus("Google Chrome Monkeys Thumb")

  local chrome = hs.window.focusedWindow():application()
  chrome:selectMenuItem({"File", "New Window"});

  local win = hs.window.focusedWindow()
  positionChatWindow(win)
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Z", function()
  setDefaultAudioDevices()
  setUpVideo("Zoom");
  setUpChatClock()

  hs.application.launchOrFocus("zoom.us")
  local win = hs.window.find("Zoom Meeting")

  if (win ~= nil)
  then
    positionChatWindow(win)
  else
    hs.alert.show("Open the Zoom Meeting first")
  end
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "M", function()
  setDefaultAudioDevices()
  setUpVideo("Unknown");
  setUpChatClock()

  hs.application.launchOrFocus("Google Chrome Monkeys Thumb")

  local chrome = hs.window.focusedWindow():application()
  chrome:selectMenuItem({"File", "New Window"});

  local win = hs.window.focusedWindow()
  positionChatWindow(win)
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "C", function()
  local clock = hs.application.get(CLOCK_APP_BUNDLE_ID)
  if clock ~= nil
  then
    clock:kill()
  else
    setUpChatClock()
  end
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "E", function()
  local clock = hs.application.get(CLOCK_APP_BUNDLE_ID)
  if clock ~= nil
  then
    clock:kill()
  end

  local obs = hs.application.get(OBS_APP_BUNDLE_ID)
  if obs ~= nil
  then
    obs:kill9()
  end

  local input = hs.audiodevice.defaultInputDevice()
  if not input:inputMuted()
  then
    input:setInputMuted(true)
  end
end)

function setFirstMatchingOutputDevice(outputNames)
  for _, value in ipairs(outputNames)
  do
    local output = hs.audiodevice.findOutputByName(value)
    if output ~= nil
    then
      output:setDefaultOutputDevice()
      return
    end
  end
end

function setFirstMatchingInputDevice(inputNames)
  for _, value in ipairs(inputNames)
  do
    local input = hs.audiodevice.findInputByName(value)
    if input ~= nil
    then
      input:setDefaultInputDevice()
      return
    end
  end
end

function setDefaultAudioDevices()
  local preferredOutputNames = { "OpenRun Pro by Shokz", "LG UltraFine Display Audio", "MacBook Pro Speakers" }
  setFirstMatchingOutputDevice(preferredOutputNames)

  local output = hs.audiodevice.defaultOutputDevice()
  if output:outputMuted()
  then
    output:setOutputMuted(false)
  end

  local preferredInputNames = { "Shure MV7", "LG UltraFine Display Audio", "MacBook Pro Microphone"  }
  setFirstMatchingInputDevice(preferredInputNames)

  local input = hs.audiodevice.defaultInputDevice()
  if input:inputMuted()
  then
    input:setInputMuted(false)
  end
end

function setUpChatClock()
  local clock = hs.application.open(CLOCK_APP_BUNDLE_ID, 5, true)
  local win = clock:focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = CLOCK_WIDTH
  win:setFrame(f)
end

function clockOffset(screen)
  local clock = hs.application.find(CLOCK_APP_BUNDLE_ID)
  if clock and clock:focusedWindow() and clock:focusedWindow():screen() == screen
  then
    return CLOCK_WIDTH * 5 / 8
  else
    return 0
  end
end

function positionChatWindow(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + clockOffset(screen)
  f.y = max.y
  f.w = max.w - clockOffset(screen)
  f.h = max.h / 2
  win:setFrame(f)
end

function setUpVideo(callType)
  if hs.application.get(OBS_APP_BUNDLE_ID) == nil
  then
    local scene = callType == "Google" and "GM-Monitor" or "Monitor"
    local execute = "/Applications/OBS.app/Contents/MacOS/OBS --startvirtualcam --scene \"" .. scene .. "\" &"

    os.execute(execute)
  end
end

-- end video call


hs.hotkey.bind({"alt", "ctrl", "cmd"}, "W", function()
  local focussedApp = hs.window.focusedWindow():application()
  hs.alert.show(focussedApp:name())
end)
