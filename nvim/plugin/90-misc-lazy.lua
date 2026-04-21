vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'markdown-preview.nvim' then
      vim.system({ 'npm', 'install' }, { cwd = ev.data.path .. '/app' }):wait()
    elseif name == 'firenvim' then
      pcall(vim.fn['firenvim#install'], 0)
    end
  end,
})

vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_markdown_css = vim.fn.expand('$HOME/.config/nvim/style/markdown.css')
vim.g.mkdp_highlight_css = vim.fn.expand('$HOME/.config/nvim/style/highlight.css')

vim.pack.add({
  'https://github.com/iamcco/markdown-preview.nvim',
  'https://github.com/glacambre/firenvim',
  'https://github.com/ray-x/guihua.lua',
  'https://github.com/ray-x/go.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/nvzone/volt',
  'https://github.com/nvzone/floaterm',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  once = true,
  callback = function() require('go').setup() end,
})

vim.api.nvim_create_augroup('GoFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'GoFormat',
  pattern = '*.go',
  callback = function() require('go.format').goimports() end,
})

require('trouble').setup({})
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

require('floaterm').setup({})
