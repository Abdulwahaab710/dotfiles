vim.g.mapleader = ";"
vim.api.nvim_set_keymap('n', 'gf', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
if vim.fn.getcwd() == os.getenv("HOME") then
  -- redefine fzf call: vim.cmd( "let $FZF_DEFAULT_COMMAND ...
  vim.cmd("command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': []}, <bang>0)")

  vim.keymap.set("n", "<c-p>", ":FzfFiles<CR>", {});
else
  -- redefine find_files: function custom_find_files() ...

  vim.keymap.set("n", "<c-p>", require('telescope.builtin').find_files, {});
end
-- map \ to grep
vim.keymap.set('n', '\\', require('telescope.builtin').live_grep, {})
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

vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bf", ":FzfBuffers<CR>")

vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>T", ":TestFile<CR>")

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
