local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- " Code Completion and snippets --------------------{{{
  use { 'wbthomason/packer.nvim' }
  use {
    'neovim/nvim-lspconfig',
    requires = {
      "ray-x/lsp_signature.nvim",
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    }
  }
  use {
    'ray-x/navigator.lua',
    requires = {
      'ray-x/guihua.lua', run = 'cd lua/fzy && make'
    },
    config = function() require 'navigator'.setup() end,
  }
  use { 'tami5/lspsaga.nvim', branch = 'main' }
  use { 'onsails/lspkind-nvim' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'github/copilot.vim' }
  use {
    'L3MON4D3/LuaSnip',
    requires = { 'rafamadriz/friendly-snippets' },
    -- config = function() require('config.snippets') end,
  }
  use { 'saadparwaiz1/cmp_luasnip' }

  -- For vsnip users.
  --[[ use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/vim-vsnip' } ]]

  -- Linting
  -- use { 'jose-elias-alvarez/null-ls.nvim' }
  use {
    "folke/trouble.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
  }
  -- " }}}

  -- DAP (Debug Adapter Protocol)
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'suketa/nvim-dap-ruby',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    }
  }

  -- " git plugins -------------------------------------{{{
  use { 'lewis6991/gitsigns.nvim', branch = 'main' }
  -- " }}}

  -- " tpope plugins -----------------------------------{{{
  use { 'tpope/vim-surround' } -- " easily surround things...just read docs for info
  use { 'tpope/vim-dispatch' }
  use { 'tpope/vim-dadbod' }
  use { 'tpope/vim-eunuch' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rhubarb' }
  use { 'tpope/vim-projectionist' }
  -- " }}}

  -- " misc --------------------------------------------{{{
  -- " Plug 'antoinemadec/FixCursorHold.nvim'
  -- " Plug 'vim-ctrlspace/vim-ctrlspace'
  use { 'windwp/nvim-autopairs' }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use { 'glepnir/dashboard-nvim' }
  use { 'Shougo/vimproc.vim', run = 'make' }
  use { 'Shougo/vimshell.vim' }
  use { 'ujihisa/repl.vim' }
  use { 'bogado/file-line' }
  use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use { 'junegunn/fzf.vim' }
  use { 'nvim-lua/popup.nvim' }
  use { "nvim-telescope/telescope.nvim" }
  use { 'nvim-telescope/telescope-fzy-native.nvim' }
  use { 'liuchengxu/vista.vim' }
  use { 'xolox/vim-misc' }
  use { 'mbbill/undotree' }
  use { 'janko-m/vim-test' }
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-vim-test"
    }
  }
  use { 'terryma/vim-multiple-cursors' }
  use { 'christoomey/vim-tmux-navigator' }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use { 'icatalina/vim-case-change' }
  use { 'godlygeek/tabular' }
  use { 'rhysd/vim-grammarous' }
  use { 'dstein64/vim-startuptime' }
  use { 'junegunn/vim-emoji' }
  use { 'voldikss/vim-floaterm' }
  -- " }}}

  -- " Syntax plugins ----------------------------------{{{
  -- " Plug 'rust-lang/rust.vim'
  -- " Plug 'ekalinin/Dockerfile.vim'
  use { 'chrisbra/csv.vim' }
  -- " Plug 'gabrielelana/vim-markdown'
  -- " Plug 'kana/vim-textobj-user'
  -- " Plug 'nelstrom/vim-textobj-rubyblock'
  -- " }}}

  -- " Theme related plugins ---------------------------{{{
  -- " Plug 'vim-airline/vim-airline-themes'
  -- " Plug 'vim-airline/vim-airline'
  use { 'romgrk/barbar.nvim' }
  use { 'glepnir/galaxyline.nvim', branch = 'main' }
  use { 'RRethy/nvim-base16' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'ryanoasis/vim-devicons' } -- " TODO: Migrate to lua
  use { 'kyazdani42/nvim-web-devicons' } -- " lua
  use { 'folke/tokyonight.nvim' }
  use { 'jeffkreeftmeijer/vim-dim', branch = 'main' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'folke/todo-comments.nvim', branch = 'main' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter-refactor' }
  use { 'andymass/vim-matchup' }
  use { 'Pocco81/TrueZen.nvim', branch = 'main' }
  --[[ use {
    "Shatur/neovim-ayu",
    config = function()
      require('ayu').setup({
          mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
          overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      })
    end
  } ]]
  use { 'sam4llis/nvim-tundra' }

  -- " }}}

  -- " Tools -------------------------------------------{{{
  use { 'mhinz/vim-rfc' }
  -- " }}}

  -- " Note Taking Plugins -----------------------------{{{
  use { 'vimwiki/vimwiki', branch = 'dev' }
  use { 'junegunn/goyo.vim' }
  use { 'junegunn/limelight.vim' }
  use { 'dhruvasagar/vim-table-mode' }
  use { 'tools-life/taskwiki', run = 'pip3 install --upgrade -r requirements.txt' }
  use { 'ekickx/clipboard-image.nvim', branch = 'main' }
  -- use { 'abdulwahaab710/vimwiki-sync' }
  use { "ellisonleao/glow.nvim" }
  -- use { 'renerocksai/telekasten.nvim' }
  use { 'mickael-menu/zk-nvim' }
  --[[ use {
    'lukas-reineke/headlines.nvim',
    config = function()
      require("headlines").setup()
    end,
  } ]]
end)
