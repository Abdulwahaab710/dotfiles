vim.pack.add({
  'https://github.com/luckasRanarison/nvim-devdocs',
  'https://github.com/Vigemus/iron.nvim',
  'https://github.com/Owen-Dechow/nvim_json_graph_view',
  'https://github.com/j-hui/fidget.nvim',
  { src = 'https://github.com/akinsho/git-conflict.nvim', version = vim.version.range('*') },
  'https://github.com/banjo/contextfiles.nvim',
})

require('nvim-devdocs').setup({})

local iron = require('iron.core')
local view = require('iron.view')
local common = require('iron.fts.common')

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = { command = { 'zsh' } },
      python = {
        command = { 'python3' },
        format = common.bracketed_paste_python,
        block_dividers = { '# %%', '#%%' },
      },
    },
    repl_filetype = function(bufnr, ft) return ft end,
    repl_open_cmd = view.bottom(40),
  },
  keymaps = {
    toggle_repl = '<space>rr',
    restart_repl = '<space>rR',
    send_motion = '<space>sc',
    visual_send = '<space>sc',
    send_file = '<space>sf',
    send_line = '<space>sl',
    send_paragraph = '<space>sp',
    send_until_cursor = '<space>su',
    send_mark = '<space>sm',
    send_code_block = '<space>sb',
    send_code_block_and_move = '<space>sn',
    mark_motion = '<space>mc',
    mark_visual = '<space>mc',
    remove_mark = '<space>md',
    cr = '<space>s<cr>',
    interrupt = '<space>s<space>',
    exit = '<space>sq',
    clear = '<space>cl',
  },
  highlight = { italic = true },
  ignore_blank_lines = true,
})
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

pcall(function() require('videre').setup({ round_units = false }) end)

require('fidget').setup()

require('git-conflict').setup({})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
    vim.keymap.set('n', 'cww', function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end,
})
