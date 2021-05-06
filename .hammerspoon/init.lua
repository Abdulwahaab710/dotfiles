stackline = require "stackline.stackline.stackline"
stackline:init()

-- bind alt+ctrl+t to toggle stackline icons
hs.hotkey.bind({'alt', 'ctrl'}, 't', function()
    stackline.config:toggle('appearance.showIcons')
end)
