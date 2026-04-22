vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/windwp/nvim-autopairs',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/RRethy/nvim-treesitter-endwise',
})

require('plugins_config.treesitter')
