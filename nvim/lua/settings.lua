vim.opt.background     = "dark"
vim.opt.termguicolors  = true
vim.opt.relativenumber = true                          -- set relative numbered lines
vim.opt.number         = true                          -- show line numbers
vim.opt.ai             = true                          -- Auto indent
vim.opt.backspace      = { "indent", "eol", "start" }
vim.opt.cursorline     = true                          -- highlight current line
vim.opt.encoding       = "utf8"
vim.opt.expandtab      = true                          -- tabs are spaces
vim.opt.foldenable     = true                          -- enable folding
vim.opt.foldlevelstart = 10                            -- open most folds by default
vim.opt.foldnestmax    = 10                            -- 10 nested fold max
vim.opt.hlsearch       = true                          -- highlight matches
vim.opt.incsearch      = true                          -- search as characters are entered
vim.opt.laststatus     = 3
vim.opt.lazyredraw     = true                          -- redraw only when we need to.
vim.opt.list           = true
vim.opt.listchars      = "eol:$,tab:␉·,trail:␠,nbsp:⎵" -- show $ in the end of line
vim.opt.mouse          = "a"
vim.opt.wrap           = false
vim.opt.path           = vim.opt.path + "**"           -- let find search in sub folders
vim.opt.re             = 1
vim.opt.ruler          = true
vim.opt.showcmd        = true                          -- show command in bottom bar
vim.opt.showmatch      = true                          -- highlight matching [{()}]
vim.opt.softtabstop    = 2                             -- number of spaces in tab when editing
vim.opt.splitbelow     = true                          -- open horizontal splits to the botton
vim.opt.splitright     = true                          -- open vertical splits to the right
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2                             -- number of visual spaces per TAB
vim.opt.ttimeoutlen    = 10
vim.opt.timeoutlen     = 10
vim.opt.ttyfast        = true
vim.opt.wildignore     = "*.o,*.class,*.pyc,*.git"
vim.opt.wildmenu       = true                          -- visual autocomplete for command menu
vim.opt.dictionary     = "/usr/share/dict/words"       -- Set the path to the dictionary
vim.opt.rtp            = vim.opt.rtp + "/opt/homebrew/opt/fzf"
vim.opt.viewoptions    = "cursor,slash,unix"
vim.opt.shell          = os.getenv("SHELL")            -- Change vim"s shell to use $SHELL
vim.opt.signcolumn     = "yes"
vim.opt.undofile       = true
vim.opt.pumblend       = 20
vim.opt.undodir        = vim.fn.expand("$HOME/.vim/undofiles")
vim.opt.backup         = false
vim.opt.spell          = true
vim.opt.backupdir      = vim.fn.expand("$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp")
vim.opt.backupskip     = "/tmp/*,/private/tmp/*"
vim.opt.directory      = vim.fn.expand("$HOME/.vim-tmp,$HOME/.tmp,$HOME/tmp,/var/tmp,/tmp")
vim.opt.writebackup    = true
vim.cmd([[packadd cfilter]])
vim.g.vimwiki_key_mappings = {
  all_maps = 1,
  global = 1,
  headers = 1,
  text_objs = 1,
  table_format = 1,
  table_mappings = 0,
  lists = 1,
  links = 1,
  html = 1,
  mouse = 0,
}
vim.g.fzf_command_prefix = "Fzf"

-- Set the python3 host program
if vim.fn.executable(vim.fn.expand("$HOME/.pyenv/versions/neovim3/bin/python")) == 1 then
  vim.g.python3_host_prog = vim.fn.expand("$HOME/.pyenv/versions/neovim3/bin/python")
else
  vim.g.python3_host_prog = vim.fn.expand("/opt/homebrew/bin/python3")
end
