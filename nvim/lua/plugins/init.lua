-- local execute = vim.api.nvim_command
-- local fn = vim.fn
--
-- local packer_install_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
--
-- local plug_url_format = 'https://github.com/%s'
--
-- local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
-- local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)
--
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
--
-- if fn.empty(fn.glob(packer_install_dir)) > 0 then
--   vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})
--   execute(install_cmd)
--   execute 'packadd packer.nvim'
--   execute 'PackerSync'
-- end
--
-- vim.cmd [[packadd packer.nvim]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- return require('packer').startup(function()
-- " Code Completion and snippets --------------------{{{
local plugins = {
  { 'wbthomason/packer.nvim' },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "solargraph",
        "sorbet"
      }
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "ray-x/lsp_signature.nvim",
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    },
  },
  {
    'ray-x/navigator.lua',
    dependencies = {
      { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
    config = function() require 'navigator'.setup() end,
  },
  { 'tami5/lspsaga.nvim', branch = 'main' },
  { 'onsails/lspkind-nvim' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  --  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'github/copilot.vim' },
  {
    "thmsmlr/gpt.nvim",
    config = function()
      require('gpt').setup({
        api_key = os.getenv("OPENAI_API_KEY")
      })

      opts = { silent = true, noremap = true },
          vim.keymap.set('v', '<C-g>r', require('gpt').replace, {
            silent = true,
            noremap = true,
            desc = "[G]pt [R]ewrite"
          })
      vim.keymap.set('v', '<C-g>p', require('gpt').visual_prompt, {
        silent = false,
        noremap = true,
        desc = "[G]pt [P]rompt"
      })
      vim.keymap.set('n', '<C-g>p', require('gpt').prompt, {
        silent = true,
        noremap = true,
        desc = "[G]pt [P]rompt"
      })
      vim.keymap.set('n', '<C-g>c', require('gpt').cancel, {
        silent = true,
        noremap = true,
        desc = "[G]pt [C]ancel"
      })
      vim.keymap.set('i', '<C-g>p', require('gpt').prompt, {
        silent = true,
        noremap = true,
        desc = "[G]pt [P]rompt"
      })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = {
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  -- Linting
  --  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    "folke/trouble.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
  },
  -- " },},},

  -- DAP (Debug Adapter Protocol)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'suketa/nvim-dap-ruby',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    },
  },

  -- " git plugins -------------------------------------{{{
  { 'lewis6991/gitsigns.nvim', branch = 'main' },
  -- " },},},

  -- " tpope plugins -----------------------------------{{{
  { 'tpope/vim-surround' }, -- " easily surround things...just read docs for info
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-dadbod' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-projectionist' },
  -- " },},},

  -- " misc --------------------------------------------{{{
  { 'windwp/nvim-autopairs' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  { 'glepnir/dashboard-nvim' },
  { 'Shougo/vimproc.vim', build = 'make' },
  { 'Shougo/vimshell.vim' },
  { 'ujihisa/repl.vim' },
  { 'bogado/file-line' },
  { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
  { 'junegunn/fzf.vim' },
  { 'nvim-lua/popup.nvim' },
  { "nvim-telescope/telescope.nvim" },
  { 'nvim-telescope/telescope-fzy-native.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    dependencies = { "kkharji/sqlite.lua" },
  },
  { 'liuchengxu/vista.vim' },
  { 'xolox/vim-misc' },
  { 'mbbill/undotree' },
  { 'janko-m/vim-test' },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-vim-test",
      "zidhuss/neotest-minitest",
    },
  },
  { 'terryma/vim-multiple-cursors' },
  { 'christoomey/vim-tmux-navigator' },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },

  { 'icatalina/vim-case-change' },
  { 'godlygeek/tabular' },
  { 'rhysd/vim-grammarous' },
  { 'dstein64/vim-startuptime' },
  { 'junegunn/vim-emoji' },
  { 'voldikss/vim-floaterm' },
  -- " },},},

  -- " Syntax plugins ----------------------------------{{{
  { 'chrisbra/csv.vim' },
  -- " },},},

  -- " Theme related plugins ---------------------------{{{
  { 'nvim-lualine/lualine.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'ryanoasis/vim-devicons' }, -- " TODO: Migrate to lua
  { 'kyazdani42/nvim-web-devicons' }, -- " lua
  { 'jeffkreeftmeijer/vim-dim', branch = 'main' },
  { 'nvim-lua/plenary.nvim' },
  { 'folke/todo-comments.nvim', branch = 'main' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'lewis6991/spellsitter.nvim', -- TODO: Remove when updating to neovim v8
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-refactor'
    },
  },
  { 'andymass/vim-matchup' },
  { 'Pocco81/TrueZen.nvim', branch = 'main' },
  { 'catppuccin/nvim' },
  -- " },},},

  -- " Tools -------------------------------------------{{{
  { 'mhinz/vim-rfc' },
  -- " },},},

  -- " Note Taking Plugins -----------------------------{{{
  { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' },
  { 'dhruvasagar/vim-table-mode' },
  {
    'tools-life/taskwiki',
    build = 'pip3 install --upgrade packaging && pip3 install --upgrade -r requirements.txt',
    dependencies = {
      'vimwiki/vimwiki',
    },
  },
  { 'ekickx/clipboard-image.nvim', branch = 'main' },
  { "ellisonleao/glow.nvim" },
  { 'mickael-menu/zk-nvim' },
  { 'nullchilly/fsread.nvim' },
}

return require("lazy").setup(plugins, opts)
