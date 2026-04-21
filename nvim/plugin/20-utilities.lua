vim.pack.add({
  'https://github.com/folke/todo-comments.nvim',
  { src = 'https://github.com/echasnovski/mini.nvim', version = vim.version.range('*') },
  'https://github.com/hedyhli/outline.nvim',
  'https://github.com/yorickpeterse/nvim-pqf',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/andymass/vim-matchup',
})

require('plugins_config.todo-comments')

require('mini.ai').setup()
require('mini.surround').setup()
require('mini.bracketed').setup()

require('outline').setup({})
vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

require('pqf').setup({
  signs = {
    error = { text = 'E', hl = 'DiagnosticSignError' },
    warning = { text = 'W', hl = 'DiagnosticSignWarn' },
    info = { text = 'I', hl = 'DiagnosticSignInfo' },
    hint = { text = 'H', hl = 'DiagnosticSignHint' },
  },
  show_multiple_lines = false,
  max_filename_length = 0,
  filename_truncate_prefix = '[...]',
})

require('Comment').setup()
