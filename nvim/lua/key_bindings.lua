-- vim.keymap.set('n', '<leader>T', function ()
--   local neotest = require("neotest")
--   neotest.run.run(vim.fn.expand("%"))
--   neotest.summary.open()
-- end)
-- vim.keymap.set('n', '<leader>t', function ()
--   local neotest = require("neotest")
--   neotest.run.run()
--   neotest.summary.open()
-- end)

vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
--- In lsp attach function
-- local map = vim.api.nvim_buf_set_keymap
-- map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
-- map(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
-- map(0, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
-- map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
-- map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
-- map(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
-- map(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
-- map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
-- map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
