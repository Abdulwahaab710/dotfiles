vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/catppuccin/nvim',
  'https://github.com/nyoom-engineering/oxocarbon.nvim',
})

require('kanagawa').setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors)
    return {}
  end,
  theme = 'dragon',
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
})

vim.cmd.colorscheme('kanagawa')

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { ctermbg = 0, fg = '#fab388', bg = '#224CBD' })

vim.api.nvim_create_user_command('LightTheme', function()
  require('kanagawa').setup({ transparent = false })
  vim.cmd('colorscheme kanagawa')
  vim.cmd('set background=light')
end, {})

vim.api.nvim_create_user_command('DarkTheme', function()
  require('kanagawa').setup({ transparent = true })
  vim.cmd('colorscheme kanagawa')
  vim.cmd('set background=dark')
end, {})
