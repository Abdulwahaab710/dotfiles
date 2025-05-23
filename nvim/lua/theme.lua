--[[ require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {     -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,    -- Force no italic
  no_bold = false,      -- Force no bold
  no_underline = false, -- Force no underline
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = function(C)
    return {
      CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
      CmpItemKindKeyword = { fg = C.base, bg = C.red },
      CmpItemKindText = { fg = C.base, bg = C.teal },
      CmpItemKindMethod = { fg = C.base, bg = C.blue },
      CmpItemKindConstructor = { fg = C.base, bg = C.blue },
      CmpItemKindFunction = { fg = C.base, bg = C.blue },
      CmpItemKindFolder = { fg = C.base, bg = C.blue },
      CmpItemKindModule = { fg = C.base, bg = C.blue },
      CmpItemKindConstant = { fg = C.base, bg = C.peach },
      CmpItemKindField = { fg = C.base, bg = C.green },
      CmpItemKindProperty = { fg = C.base, bg = C.green },
      CmpItemKindEnum = { fg = C.base, bg = C.green },
      CmpItemKindUnit = { fg = C.base, bg = C.green },
      CmpItemKindClass = { fg = C.base, bg = C.yellow },
      CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
      CmpItemKindFile = { fg = C.base, bg = C.blue },
      CmpItemKindInterface = { fg = C.base, bg = C.yellow },
      CmpItemKindColor = { fg = C.base, bg = C.red },
      CmpItemKindReference = { fg = C.base, bg = C.red },
      CmpItemKindEnumMember = { fg = C.base, bg = C.red },
      CmpItemKindStruct = { fg = C.base, bg = C.blue },
      CmpItemKindValue = { fg = C.base, bg = C.peach },
      CmpItemKindEvent = { fg = C.base, bg = C.blue },
      CmpItemKindOperator = { fg = C.base, bg = C.blue },
      CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
      CmpItemKindCopilot = { fg = C.base, bg = C.teal },
    }
  end,
  integrations = {
    -- cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin" ]]

-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "dragon",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "kanagawa"

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {ctermbg=0, fg="#fab388", bg="#224CBD"})

vim.api.nvim_create_user_command("LightTheme",
  function()
    require("kanagawa").setup({
      transparent = false,
    })
    vim.cmd("colorscheme kanagawa")
    vim.cmd("set background=light")
  end,
  {}
)

vim.api.nvim_create_user_command("DarkTheme",
  function()
    require("kanagawa").setup({
      transparent = true,
    })
    vim.cmd("colorscheme kanagawa")
    vim.cmd("set background=dark")
  end,
  {}
)

