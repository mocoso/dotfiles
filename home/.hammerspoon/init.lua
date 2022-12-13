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

-- Video call

CLOCK_WIDTH = 250

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "M", function()
  setUpAudioVideoForCall()
  setUpChatClock()

  hs.application.launchOrFocus("Google Chrome Monkeys Thumb")

  local chrome = hs.window.focusedWindow():application()
  chrome:selectMenuItem({"File", "New Window"});

  local win = hs.window.focusedWindow()
  positionChatWindow(win)
end)

hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Z", function()
  setUpAudioVideoForCall()
  setUpChatClock()

  local win = hs.window.find("Zoom Meeting")

  if (win ~= nil)
  then
    positionChatWindow(win)
  else
    hs.alert.show("Open the Zoom Meeting first")
  end
end)

function setUpAudioVideoForCall()
  setDefaultAudioDevices()
  setUpVideo();
end

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
  hs.application.launchOrFocus("Smart Countdown Timer")
  hs.timer.doAfter(0.2, positionChatClock)
end

function positionChatClock()
  local application = hs.application.find("Smart Countdown Timer")
  local win = application:focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x
  f.y = max.y
  f.w = CLOCK_WIDTH
  win:setFrame(f)
end

function positionChatWindow(win)
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x + (CLOCK_WIDTH * 5 / 8)
  f.y = max.y
  f.w = max.w - (CLOCK_WIDTH * 5 / 8)
  f.h = max.h / 2
  win:setFrame(f)
end

function setUpVideo()
  if hs.application.get("OBS") == nil
  then
    os.execute("/Applications/OBS.app/Contents/MacOS/OBS --startvirtualcam &")
  end
end

-- end video call
