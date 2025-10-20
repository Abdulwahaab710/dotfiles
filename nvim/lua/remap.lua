vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.g.mapleader = ";"
vim.keymap.set("n", "<C-f>",
  "<cmd>silent !CALL_FROM_NVIM=1 /Users/abdulwahaabahmed/src/github.com/abdulwahaab710/dotfiles/bin/.local/tmux-sessionizer<CR>")

-- disabling arrow keys
vim.keymap.set({ "n", "i", "", "v" }, "<up>", "<nop>")
vim.keymap.set({ "n", "i", "", "v" }, "<down>", "<nop>")
vim.keymap.set({ "n", "i", "", "v" }, "<left>", "<nop>")
vim.keymap.set({ "n", "i", "", "v" }, "<right>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>x", ":x<CR>")
vim.keymap.set("n", "<leader>n", ":nohl<CR>")

vim.keymap.set({ "n", "v" }, "<leader>gb", ":GBrowse<CR>")
vim.keymap.set({ "n", "v" }, "<leader>gB", ":GBrowse!<CR>")

vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bf", ":FzfBuffers<CR>")

-- vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
-- vim.keymap.set("n", "<leader>T", ":TestFile<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")

vim.keymap.set("v", "<leader>n", ":ZkNewFromTitleSelection<CR>")

local group = vim.api.nvim_create_augroup("textfile_group", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.keymap.set("v", "<F7>", ":ChatGPTRun grammar_correction<CR>", {})
  end,
  pattern = { "text", "markdown", "md", "wiki" },
  group = group
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
  pattern = { "vimwiki.markdown" },
  group = group
})

vim.keymap.set("n", "<Space>", "za")

--[[

nnoremap <Space> za

nmap s cl
nmap S cc
vmap s c
vmap S c
nmap <leader>bf :FzfBuffers<CR>

]]
