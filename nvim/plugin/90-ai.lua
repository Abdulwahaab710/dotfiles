vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'mcphub.nvim' then
      vim.system({ 'npm', 'install', '-g', 'mcp-hub@latest' }):wait()
    end
  end,
})

vim.pack.add({
  'https://github.com/github/copilot.vim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/coder/claudecode.nvim',
  'https://github.com/ravitemer/mcphub.nvim',
  'https://github.com/sudo-tee/opencode.nvim',
  'https://github.com/milanglacier/yarepl.nvim',
  'https://github.com/folke/sidekick.nvim',
})

require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    trigger_on_accept = true,
    keymap = {
      accept = '<tab>',
      accept_word = false,
      accept_line = false,
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<C-]>',
    },
  },
  filetypes = {
    yaml = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ['.'] = false,
  },
})

require('claudecode').setup({})
vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('v', '<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })

require('mcphub').setup({
  extensions = {
    avante = { make_slash_commands = true },
  },
})

require('opencode').setup({})

require('yarepl').setup({
  buflisted = true,
  scratch = true,
  ft = 'REPL',
  wincmd = 'belowright 15 split',
  metas = {
    aichat = { cmd = 'aichat', formatter = 'bracketed_pasting', source_func = 'aichat' },
    ruby = { cmd = 'ruby', formatter = 'trim_empty_lines', source_func = 'ruby' },
    bash = {
      cmd = 'bash',
      formatter = vim.fn.has('linux') == 1 and 'bracketed_pasting' or 'trim_empty_lines',
      source_func = 'bash',
    },
    zsh = { cmd = 'zsh', formatter = 'bracketed_pasting', source_func = 'bash' },
  },
  close_on_exit = true,
  scroll_to_bottom_after_sending = true,
  format_repl_buffers_names = true,
  os = {
    windows = { send_delayed_cr_after_sending = true },
  },
})

local keymap = vim.api.nvim_set_keymap
keymap('n', '<Leader>as', '<Plug>(REPLStart-aider)', { desc = 'Start an aider REPL' })
keymap('n', '<Leader>af', '<Plug>(REPLFocus-aider)', { desc = 'Focus on aider REPL' })
keymap('n', '<Leader>ah', '<Plug>(REPLHide-aider)', { desc = 'Hide aider REPL' })
keymap('v', '<Leader>ar', '<Plug>(REPLSendVisual-aider)', { desc = 'Send visual region to aider' })
keymap('n', '<Leader>arr', '<Plug>(REPLSendLine-aider)', { desc = 'Send lines to aider' })
keymap('n', '<Leader>ar', '<Plug>(REPLSendOperator-aider)', { desc = 'Send Operator to aider' })
keymap('n', '<Leader>ae', '<Plug>(AiderExec)', { desc = 'Execute command in aider' })
keymap('n', '<Leader>ay', '<Plug>(AiderSendYes)', { desc = 'Send y to aider' })
keymap('n', '<Leader>an', '<Plug>(AiderSendNo)', { desc = 'Send n to aider' })
keymap('n', '<Leader>ap', '<Plug>(AiderSendPaste)', { desc = 'Send /paste to aider' })
keymap('n', '<Leader>aa', '<Plug>(AiderSendAbort)', { desc = 'Send abort to aider' })
keymap('n', '<Leader>aq', '<Plug>(AiderSendExit)', { desc = 'Send exit to aider' })
keymap('n', '<Leader>ag', '<cmd>AiderSetPrefix<cr>', { desc = 'set aider prefix' })
keymap('n', '<Leader>ama', '<Plug>(AiderSendAskMode)', { desc = 'Switch aider to ask mode' })
keymap('n', '<Leader>amA', '<Plug>(AiderSendArchMode)', { desc = 'Switch aider to architect mode' })
keymap('n', '<Leader>amc', '<Plug>(AiderSendCodeMode)', { desc = 'Switch aider to code mode' })
keymap('n', '<Leader>aG', '<cmd>AiderRemovePrefix<cr>', { desc = 'remove aider prefix' })
keymap('n', '<Leader>a<space>', '<cmd>checktime<cr>', { desc = 'sync file changes by aider to nvim buffer' })

require('sidekick').setup({
  cli = {
    mux = { backend = 'tmux', enabled = true },
  },
})
vim.keymap.set({ 'n' }, '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })
vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle CLI' })
vim.keymap.set('n', '<leader>as', function() require('sidekick.cli').select() end, { desc = 'Select CLI' })
vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send({ msg = '{this}' }) end, { desc = 'Send This' })
vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send({ msg = '{selection}' }) end, { desc = 'Send Visual Selection' })
vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Sidekick Select Prompt' })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<c-.>', function() require('sidekick.cli').focus() end, { desc = 'Sidekick Switch Focus' })
vim.keymap.set('n', '<leader>ac', function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end, { desc = 'Sidekick Toggle Claude' })
