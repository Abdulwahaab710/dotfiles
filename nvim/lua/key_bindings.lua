vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
