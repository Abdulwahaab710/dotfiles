vim.g.barbar_auto_setup = false

vim.pack.add({
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  { src = 'https://github.com/romgrk/barbar.nvim', version = vim.version.range('1.x') },
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/folke/which-key.nvim',
})

require('plugins_config.gitsigns')
require('plugins_config.status-line')
require('barbar').setup({})
require('which-key').setup({})
