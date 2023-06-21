local api = vim.api
local db = require('dashboard')

local windowHeight = api.nvim_get_option("lines")
local spaceRequiredToCenter = math.floor(windowHeight / 2) - 12

vim.g.indent_blankline_filetype_exclude = {
  "dashboard",
  "Trouble",
}

local headerAscii = {
  "           ▄ ▄                   ",
  "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
  "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
  "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
  "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
  "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
  "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
  "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
  "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
  "                                 ",
}

local emmptyLine = string.rep(" ", vim.fn.strwidth(headerAscii[1]))

for i = 1, spaceRequiredToCenter do
  table.insert(headerAscii, 1, emmptyLine)
end

db.setup({
  theme = 'doom',
  config = {
    header = headerAscii,
    center = {
      {
        desc = '  Recent Files',
        group = 'RecentFiles',
        action = 'Telescope oldfiles',
        key = 'o',
      },
      {
        desc = '  File Browser',
        group = 'FileBrowser',
        action = 'Telescope file_browser',
        key = 'b',
      },
      { desc = '  Update plugins', group = '@property', action = 'PackerUpdate', key = 'u' },
      { desc = '  Today\'s Diary', group = 'Diary', action = 'VimwikiMakeDiaryNote', key = 'd' },
      {
        icon = '  ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
        key = 'f',
      },
    },
  },
})
