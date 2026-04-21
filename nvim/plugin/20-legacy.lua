vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'vimproc.vim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    elseif name == 'fzf' then
      vim.system({ './install', '--all' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-projectionist',
  'https://github.com/Shougo/vimproc.vim',
  'https://github.com/Shougo/vimshell.vim',
  'https://github.com/ujihisa/repl.vim',
  'https://github.com/bogado/file-line',
  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',
  { src = 'https://github.com/linrongbin16/fzfx.nvim', version = vim.version.range('7.x') },
  'https://github.com/nvim-lua/popup.nvim',
  'https://github.com/liuchengxu/vista.vim',
  'https://github.com/xolox/vim-misc',
  'https://github.com/mbbill/undotree',
  'https://github.com/terryma/vim-multiple-cursors',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/icatalina/vim-case-change',
  'https://github.com/godlygeek/tabular',
  'https://github.com/rhysd/vim-grammarous',
  'https://github.com/dstein64/vim-startuptime',
  'https://github.com/junegunn/vim-emoji',
  'https://github.com/chrisbra/csv.vim',
  'https://github.com/max397574/better-escape.nvim',
  'https://github.com/rmagatti/gx-extended.nvim',
})

require('plugins_config.projectionist')

require('fzfx').setup()

require('better_escape').setup({
  timeout = vim.o.timeoutlen,
  default_mappings = false,
  mappings = {
    i = { j = { k = '<Esc>' } },
    c = { j = { k = '<Esc>' } },
    t = { j = { k = '<C-\\><C-n>' } },
    s = { j = { k = '<Esc>' } },
  },
})

require('gx-extended').setup({
  extensions = {
    {
      patterns = { '*/plugins/**/*.lua' },
      name = 'neovim plugins',
      match_to_url = function(line_string)
        local line = string.match(line_string, '["|\'].*/.*["|\']')
        local repo = vim.split(line, ':')[1]:gsub('["|\']', '')
        local url = 'https://github.com/' .. repo
        return line and repo and url or nil
      end,
    },
    {
      patterns = { '*.md' },
      name = 'github links',
      match_to_url = function(line_string)
        local repo = string.match(line_string, '([a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*)')
        local issue_number = string.match(line_string, '[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*#([0-9]*)')
        local url = 'https://github.com/' .. repo .. '/issues/' .. issue_number
        return repo and issue_number and url or nil
      end,
    },
    {
      patterns = { '*.*' },
      name = 'HackerOne report',
      match_to_url = function(line_string)
        local line = string.match(line_string, 'h1[-]([0-9]*)')
        local report_id = vim.split(line, ':')[1]:gsub('["|\']', '')
        local url = 'https://hackerone.com/reports/' .. report_id
        return line and report_id and url or nil
      end,
    },
    {
      patterns = { '*.*' },
      name = 'BugBounty app report',
      match_to_url = function(line_string)
        local line = string.match(line_string, 'bb[-]([0-9]*)')
        local report_id = vim.split(line, ':')[1]:gsub('["|\']', '')
        local url = 'https://bugbounty.shopify.io/reports/' .. report_id
        return line and report_id and url or nil
      end,
    },
    {
      patterns = { '*.md' },
      name = 'Vault GSD project',
      match_to_url = function(line_string)
        local line = string.match(line_string, '#gsd[:]([0-9]*)')
        local gsd_project_id = vim.split(line, ':')[1]:gsub('["|\']', '')
        local url = 'https://vault.shopify.io/gsd/projects/' .. gsd_project_id
        return line and gsd_project_id and url or nil
      end,
    },
  },
})
