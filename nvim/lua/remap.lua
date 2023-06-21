vim.g.mapleader = ";"
vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, {})
-- map \ to grep
vim.keymap.set('n', '\\', require('telescope.builtin').live_grep, {})
vim.keymap.set("n", "<C-f>", "<cmd>silent !/Users/abdulwahaabahmed/src/github.com/abdulwahaab710/dotfiles/bin/.local/tmux-sessionizer<CR>")
-- disabling arrow keys
vim.keymap.set({"n", "i", "", "v"}, "<up>", "<nop>")
vim.keymap.set({"n", "i", "", "v"}, "<down>", "<nop>")
vim.keymap.set({"n", "i", "", "v"}, "<left>", "<nop>")
vim.keymap.set({"n", "i", "", "v"}, "<right>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>x", ":x<CR>")
vim.keymap.set("n", "<leader>n", ":nohl<CR>")

vim.keymap.set({"n", "v"}, "<leader>gb", ":GBrowse<CR>")

vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bf", ":FzfBuffers<CR>")

--[[

nnoremap <Space> za

nmap s cl
nmap S cc
vmap s c
vmap S c
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bf :FzfBuffers<CR>

]]


