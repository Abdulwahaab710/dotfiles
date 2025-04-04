-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font 'PragmataProMonoLiga Nerd Font'

config.font_size = 15

config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local home = os.getenv("HOME")

-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
local dimmer = { brightness = 0.05 }

config.enable_scroll_bar = false

config.background = {
  -- This is the deepest/back-most layer. It will be rendered first
  {
    source = {
      File = home .. "/src/github.com/abdulwahaab710/dotfiles/wallpapers/grendizer-1.png",
    },
    -- The texture tiles vertically but not horizontally.
    -- When we repeat it, mirror it so that it appears "more seamless".
    -- An alternative to this is to set `width = "100%"` and have
    -- it stretch across the display
    repeat_x = "NoRepeat",
    hsb = dimmer,

    vertical_align = "Middle",
    -- When the viewport scrolls, move this layer 10% of the number of
    -- pixels moved by the main viewport. This makes it appear to be
    -- further behind the text.
    attachment = "Fixed",
  },
}
-- and finally, return the configuration to wezterm
return config
