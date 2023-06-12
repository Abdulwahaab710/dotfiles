stackline = require "stackline"
stackline:init()

-- bind alt+ctrl+t to toggle stackline icons
hs.hotkey.bind({'alt', 'ctrl'}, 't', function()
    stackline.config:toggle('appearance.showIcons')
end)

hs.loadSpoon('ControlEscape'):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon

local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end


remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))

remap({'ctrl', 'shift'}, 'h', pressFn({'shift'}, 'left'))
remap({'ctrl', 'shift'}, 'j', pressFn({'shift'}, 'down'))
remap({'ctrl', 'shift'}, 'k', pressFn({'shift'}, 'up'))
remap({'ctrl', 'shift'}, 'l', pressFn({'shift'}, 'right'))

remap({'ctrl', 'cmd'}, 'h', pressFn({'cmd'}, 'left'))
remap({'ctrl', 'cmd'}, 'j', pressFn({'cmd'}, 'down'))
remap({'ctrl', 'cmd'}, 'k', pressFn({'cmd'}, 'up'))
remap({'ctrl', 'cmd'}, 'l', pressFn({'cmd'}, 'right'))

remap({'ctrl', 'alt'}, 'h', pressFn({'alt'}, 'left'))
remap({'ctrl', 'alt'}, 'j', pressFn({'alt'}, 'down'))
remap({'ctrl', 'alt'}, 'k', pressFn({'alt'}, 'up'))
remap({'ctrl', 'alt'}, 'l', pressFn({'alt'}, 'right'))

remap({'ctrl', 'shift', 'cmd'}, 'h', pressFn({'shift', 'cmd'}, 'left'))
remap({'ctrl', 'shift', 'cmd'}, 'j', pressFn({'shift', 'cmd'}, 'down'))
remap({'ctrl', 'shift', 'cmd'}, 'k', pressFn({'shift', 'cmd'}, 'up'))
remap({'ctrl', 'shift', 'cmd'}, 'l', pressFn({'shift', 'cmd'}, 'right'))

remap({'ctrl', 'shift', 'alt'}, 'h', pressFn({'shift', 'alt'}, 'left'))
remap({'ctrl', 'shift', 'alt'}, 'j', pressFn({'shift', 'alt'}, 'down'))
remap({'ctrl', 'shift', 'alt'}, 'k', pressFn({'shift', 'alt'}, 'up'))
remap({'ctrl', 'shift', 'alt'}, 'l', pressFn({'shift', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt'}, 'h', pressFn({'cmd', 'alt'}, 'left'))
remap({'ctrl', 'cmd', 'alt'}, 'j', pressFn({'cmd', 'alt'}, 'down'))
remap({'ctrl', 'cmd', 'alt'}, 'k', pressFn({'cmd', 'alt'}, 'up'))
remap({'ctrl', 'cmd', 'alt'}, 'l', pressFn({'cmd', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt', 'shift'}, 'h', pressFn({'cmd', 'alt', 'shift'}, 'left'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'j', pressFn({'cmd', 'alt', 'shift'}, 'down'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'k', pressFn({'cmd', 'alt', 'shift'}, 'up'))
remap({'ctrl', 'cmd', 'alt', 'shift'}, 'l', pressFn({'cmd', 'alt', 'shift'}, 'right'))

function yabai(args)
  hs.task.new("/opt/homebrew/bin/yabai",nil, function(ud, ...)
    print("stream", hs.inspect(table.pack(...)))
    return true
  end, args):start()

end


if hs.application("skhd") == nil then
  print("skhd not running")
  -- focus window
  hs.hotkey.bind("alt", "h", function() yabai({"-m", "window", "--focus", "west"}) end)
  hs.hotkey.bind("alt", "j", function() yabai({"-m", "window", "--focus", "south"}) end)
  hs.hotkey.bind("alt", "k", function() yabai({"-m", "window", "--focus", "north"}) end)
  hs.hotkey.bind("alt", "l", function() yabai({"-m", "window", "--focus", "east"}) end)

  -- swap window
  hs.hotkey.bind({"shift", "alt"}, "h", function() yabai({"-m", "window", "--swap", "west"}) end)
  hs.hotkey.bind({"shift", "alt"}, "j", function() yabai({"-m", "window", "--swap", "south"}) end)
  hs.hotkey.bind({"shift", "alt"}, "k", function() yabai({"-m", "window", "--swap", "north"}) end)
  hs.hotkey.bind({"shift", "alt"}, "l", function() yabai({"-m", "window", "--swap", "east"}) end)

  -- move window
  hs.hotkey.bind({"shift", "cmd"}, "h", function() yabai({"-m", "window", "--warp", "west"}) end)
  hs.hotkey.bind({"shift", "cmd"}, "j", function() yabai({"-m", "window", "--warp", "south"}) end)
  hs.hotkey.bind({"shift", "cmd"}, "k", function() yabai({"-m", "window", "--warp", "north"}) end)
  hs.hotkey.bind({"shift", "cmd"}, "l", function() yabai({"-m", "window", "--warp", "east"}) end)

  -- balance size of windows
  hs.hotkey.bind({"shift", "alt"}, "0", function() yabai({"-m", "space", "--balance"}) end)

  -- toggle window native fullscreen
  hs.hotkey.bind({"shift", "alt"}, "f", function() yabai({"-m", "window", "--toggle", "native-fullscreen"}) end)

  -- toggle window fullscreen zoom
  hs.hotkey.bind("alt", "f", function() yabai({"-m", "window", "--toggle", "zoom-fullscreen"}) end)

  -- make floating window fill screen
  hs.hotkey.bind({"shift", "alt"}, "up", function() yabai({"-m", "window", "--grid", "1:1:0:0:1:1"}) end)

  -- make floating window fill left-half of screen
  hs.hotkey.bind({"shift", "alt"}, "left", function() yabai({"-m", "window", "--grid", "1:2:0:0:1:1"}) end)

  -- make floating window fill right-half of screen
  hs.hotkey.bind({"shift", "alt"}, "right", function() yabai({"-m", "window", "--grid", "1:2:1:0:1:1"}) end)

  -- destroy desktop
  hs.hotkey.bind({"cmd", "alt"}, "w", function() yabai({"-m", "space", "--destroy"}) end)

  -- rotate tree
  hs.hotkey.bind("alt", "r", function() yabai({"-m", "space", "--rotate", "90"}) end)

  -- fast focus desktop
  hs.hotkey.bind({"cmd", "alt"}, "x", function() yabai({"-m", "space", "--focus", "recent"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "z", function() yabai({"-m", "space", "--focus", "prev"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "c", function() yabai({"-m", "space", "--focus", "next"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "1", function() yabai({"-m", "space", "--focus", "1"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "2", function() yabai({"-m", "space", "--focus", "2"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "3", function() yabai({"-m", "space", "--focus", "3"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "4", function() yabai({"-m", "space", "--focus", "4"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "5", function() yabai({"-m", "space", "--focus", "5"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "6", function() yabai({"-m", "space", "--focus", "6"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "7", function() yabai({"-m", "space", "--focus", "7"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "8", function() yabai({"-m", "space", "--focus", "8"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "9", function() yabai({"-m", "space", "--focus", "9"}) end)
  hs.hotkey.bind({"cmd", "alt"}, "0", function() yabai({"-m", "space", "--focus", "0"}) end)

  -- mirror tree y-axis
  hs.hotkey.bind("alt", "y", function() yabai({"-m", "space", "--mirror", "y-axis"}) end)

  -- mirror tree x-axis
  hs.hotkey.bind("alt", "x", function() yabai({"-m", "space", "--mirror", "x-axis"}) end)

  -- toggle desktop offset
  hs.hotkey.bind("alt", "a", function() yabai({"-m", "space", "--toggle", "padding"}); yabai({"-m", "space", "--toggle", "gap"}) end)

  -- toggle window parent zoom
  hs.hotkey.bind("alt", "d", function() yabai({"-m", "window", "--toggle", "zoom-parent"}) end)

  -- toggle window border
  hs.hotkey.bind({"shift", "alt"}, "b", function() yabai({"-m", "window", "--toggle", "border"}) end)

  -- toggle window split type
  hs.hotkey.bind("alt", "e", function() yabai({"-m", "window", "--toggle", "split"}) end)

  -- toggle sticky
  hs.hotkey.bind("alt", "s", function() yabai({"-m", "window", "--toggle", "sticky"}) end)

  -- Reload yabai
  hs.hotkey.bind({"ctrl", "shift", "cmd"}, "r", function() hs.execute("launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\"") end)
-- Stack binding
  hs.hotkey.bind({"shift", "alt"}, "n", function() hs.execute("/opt/homebrew/bin/yabai -m window --focus stack.prev || /opt/homebrew/bin/yabai -m window --focus prev || /opt/homebrew/bin/yabai -m window --focus last") end)
  hs.hotkey.bind("alt", "n", function() hs.execute("/opt/homebrew/bin/yabai -m window --focus stack.next || /opt/homebrew/bin/yabai -m window --focus next || /opt/homebrew/bin/yabai -m window --focus first") end)
  hs.hotkey.bind("alt", "tab", function() yabai({"-m", "window", "--focus", "stack.recent"}) end)
  hs.hotkey.bind({"cmd", "ctrl"}, "left", function() hs.execute("/opt/homebrew/bin/yabai -m window west --stack $(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')") end)
  hs.hotkey.bind({"cmd", "ctrl"}, "down", function() hs.execute("/opt/homebrew/bin/yabai -m window south --stack $(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')") end)
  hs.hotkey.bind({"cmd", "ctrl"}, "up", function() hs.execute("/opt/homebrew/bin/yabai -m window north --stack $(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')") end)
  hs.hotkey.bind({"cmd", "ctrl"}, "right", function() hs.execute("/opt/homebrew/bin/yabai -m window east --stack $(/opt/homebrew/bin/yabai -m query --windows --window | /opt/homebrew/bin/jq -r '.id')") end)
-- float / unfloat window and center on screen
  hs.hotkey.bind("alt", "t", function() yabai({"-m", "window", "--toggle", "float"}); yabai({"-m", "window", "--grid", "4:4:1:1:2:2"}) end)
end

--[[
-- create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
shift + ctrl - n : yabai -m space --create && \
                  index="$(yabai -m query --displays --display | jq '.spaces[-1]')" && \
                  yabai -m window --space "${index}" && \
                  yabai -m space --focus "${index}"

-- create desktop and follow focus - uses jq for parsing json (brew install jq)
ctrl + alt - n : yabai -m space --create;\
                  index="$(yabai -m query --displays --display | jq '.spaces[-1]')" && \
                  yabai -m space --focus "${index}"

-- send window to desktop and follow focus
shift + ctrl - x : yabai -m window --space recent; yabai -m space --focus recent
shift + ctrl - z : yabai -m window --space prev; yabai -m space --focus prev
shift + ctrl - c : yabai -m window --space next; yabai -m space --focus next
shift + ctrl - 1 : yabai -m window --space  1; yabai -m space --focus 1
shift + ctrl - 2 : yabai -m window --space  2; yabai -m space --focus 2
shift + ctrl - 3 : yabai -m window --space  3; yabai -m space --focus 3
shift + ctrl - 4 : yabai -m window --space  4; yabai -m space --focus 4
shift + ctrl - 5 : yabai -m window --space  5; yabai -m space --focus 5
shift + ctrl - 6 : yabai -m window --space  6; yabai -m space --focus 6
shift + ctrl - 7 : yabai -m window --space  7; yabai -m space --focus 7
shift + ctrl - 8 : yabai -m window --space  8; yabai -m space --focus 8
shift + ctrl - 9 : yabai -m window --space  9; yabai -m space --focus 9
shift + ctrl - 0 : yabai -m window --space 10; yabai -m space --focus 10

-- focus monitor
ctrl + alt - x  : yabai -m display --focus recent
ctrl + alt - z  : yabai -m display --focus prev
ctrl + alt - c  : yabai -m display --focus next
ctrl + alt - 1  : yabai -m display --focus 1
ctrl + alt - 2  : yabai -m display --focus 2
ctrl + alt - 3  : yabai -m display --focus 3

-- send window to monitor and follow focus
ctrl + cmd - x  : yabai -m window --display recent; yabai -m display --focus recent
ctrl + cmd - z  : yabai -m window --display prev; yabai -m display --focus prev
ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3

-- move window
shift + ctrl - a : yabai -m window --move rel:-20:0
shift + ctrl - s : yabai -m window --move rel:0:20
shift + ctrl - w : yabai -m window --move rel:0:-20
shift + ctrl - d : yabai -m window --move rel:20:0

-- increase window size
shift + alt - a : yabai -m window --resize left:-20:0
shift + alt - s : yabai -m window --resize bottom:0:20
shift + alt - w : yabai -m window --resize top:0:-20
shift + alt - d : yabai -m window --resize right:20:0

-- decrease window size
shift + cmd - a : yabai -m window --resize left:20:0
shift + cmd - s : yabai -m window --resize bottom:0:-20
shift + cmd - w : yabai -m window --resize top:0:20
shift + cmd - d : yabai -m window --resize right:-20:0

-- set insertion point in focused container
ctrl + alt - h : yabai -m window --insert west
ctrl + alt - j : yabai -m window --insert south
ctrl + alt - k : yabai -m window --insert north
ctrl + alt - l : yabai -m window --insert east
ctrl + alt - i : yabai -m window --insert stack

-- change layout of desktop
ctrl + alt - a : yabai -m space --layout bsp
ctrl + alt - d : yabai -m space --layout float

-- Stack binding
shift + alt - n : yabai -m window --focus stack.prev || yabai -m window --focus prev || yabai -m window --focus last
alt - n : yabai -m window --focus stack.next || yabai -m window --focus next || yabai -m window --focus first
alt - tab: yabai -m window --focus stack.recent
cmd + ctrl - left  : yabai -m window west --stack $(yabai -m query --windows --window | jq -r '.id')
cmd + ctrl - down  : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id')
cmd + ctrl - up    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id')
cmd + ctrl - right : yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id')
-- float / unfloat window and center on screen
alt - t : yabai -m window --toggle float;\
          yabai -m window --grid 4:4:1:1:2:2

-- toggle sticky, float and resize to picture-in-picture size
alt -p : yabai -m window --toggle sticky;\
          yabai -m window --grid 5:5:4:0:1:1
--]]

--------------------------------
-- START VIM CONFIG
--------------------------------
--[[ local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

-- Configure apps you do *not* want Vim mode enabled in
-- For example, you don't want this plugin overriding your control of Terminal
-- vim
vim
  :disableForApp('Code')
  :disableForApp('zoom.us')
  :disableForApp('iTerm')
  :disableForApp('iTerm2')
  :disableForApp('Terminal')
  :disableForApp('Kitty')

-- If you want the screen to dim (a la Flux) when you enter normal mode
-- flip this to true.
vim:shouldDimScreenInNormalMode(false)

-- If you want to show an on-screen alert when you enter normal mode, set
-- this to true
vim:shouldShowAlertInNormalMode(true)

-- You can configure your on-screen alert font
vim:setAlertFont("Courier New")

-- Enter normal mode by typing a key sequence
vim:enterWithSequence('jk')

-- if you want to bind a single key to entering vim, remove the
-- :enterWithSequence('jk') line above and uncomment the bindHotKeys line
-- below:
--
-- To customize the hot key you want, see the mods and key parameters at:
--   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
-- vim:bindHotKeys({ enter = { {'ctrl'}, ';' } })

--------------------------------
-- END VIM CONFIG
-------------------------------- ]]
