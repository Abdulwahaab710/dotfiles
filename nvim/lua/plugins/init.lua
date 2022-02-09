local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- " Code Completion and snippets --------------------{{{
  use { 'rafamadriz/friendly-snippets' }
  use { 'neovim/nvim-lspconfig' }
  use { 'tami5/lspsaga.nvim',  branch = 'main' }
  use { 'onsails/lspkind-nvim' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'williamboman/nvim-lsp-installer' }

  -- For vsnip users.
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/vim-vsnip' }

  -- Linting
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  -- " }}}

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
  use { 'hardcoreplayers/dashboard-nvim' }
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
  use { 'benjifisher/matchit.zip' }
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
  use { 'Pocco81/TrueZen.nvim', branch = 'main' }
  use { 'ray-x/aurora' }
  use { "projekt0n/github-nvim-theme" }

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
  use { 'renerocksai/telekasten.nvim' }
  --[[ use {
    'lukas-reineke/headlines.nvim',
    config = function()
      require("headlines").setup()
    end,
  } ]]
end)
