-- " Code Completion and snippets --------------------{{{
return {
  {
    'j-hui/fidget.nvim',
    branch = 'legacy',
    config = function()
      require('fidget').setup()
    end
  },
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
        "sorbet",
        "lua_ls"
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
<<<<<<< HEAD:nvim/lua/plugins/all.lua
  {
    'ray-x/navigator.lua',
    dependencies = {
      { 'ray-x/guihua.lua',     build = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  },
  { 'tami5/lspsaga.nvim',  branch = 'main' },
=======
  -- {
  --   'ray-x/navigator.lua',
  --   dependencies = {
  --     { 'ray-x/guihua.lua',     build = 'cd lua/fzy && make' },
  --     { 'neovim/nvim-lspconfig' },
  --   },
  --   config = function() require 'navigator'.setup() end,
  -- },
  { 'tami5/lspsaga.nvim',    branch = 'main' },
>>>>>>> c926e22 (Update nvim configs):nvim/lua/plugins/init.lua
  { 'onsails/lspkind-nvim' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  --  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  { 'github/copilot.vim' },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
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
      "nvim-tree/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
  },
  -- " }}}

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
  -- " }}}

  -- " tpope plugins -----------------------------------{{{
  { 'tpope/vim-surround' }, -- " easily surround things...just read docs for info
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-dadbod' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-projectionist' },
  -- " }}}

  -- " misc --------------------------------------------{{{
  { 'windwp/nvim-autopairs' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  { 'glepnir/dashboard-nvim' },
  { 'Shougo/vimproc.vim',    build = 'make' },
  { 'Shougo/vimshell.vim' },
  { 'ujihisa/repl.vim' },
  { 'bogado/file-line' },
  {
    'junegunn/fzf',
    dir = '~/.fzf',
    -- build = './install --all',
    build = 'fzf#install()',
    dependencies = {
      'junegunn/fzf.vim'
    },
  },
  { "nvim-tree/nvim-web-devicons" },
  -- mandatory
  { "junegunn/fzf",               build = ":call fzf#install()" },
  {
    "linrongbin16/fzfx.nvim",
    dependencies = { "junegunn/fzf" },
    config = function()
      require("fzfx").setup()
    end
  },
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
  -- " }}}

  -- " Syntax plugins ----------------------------------{{{
  { 'chrisbra/csv.vim' },
  -- " }}}

  -- " Theme related plugins ---------------------------{{{
  { 'nvim-lualine/lualine.nvim' },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  { 'lukas-reineke/indent-blankline.nvim' },
  -- { 'ryanoasis/vim-devicons' }, -- " TODO: Migrate to lua
  { 'nvim-lua/plenary.nvim' },
  { 'folke/todo-comments.nvim',           branch = 'main' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-refactor',
      'RRethy/nvim-treesitter-endwise'
    },
  },
  { 'andymass/vim-matchup' },
  { 'Pocco81/TrueZen.nvim',            branch = 'main' },
  { 'catppuccin/nvim' },
  { 'nyoom-engineering/oxocarbon.nvim' },

  --[[ {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }, ]]
  -- " }}}
};

<<<<<<< HEAD:nvim/lua/plugins/all.lua
-- vim.g.vimwiki_ext2syntax = { ['.wiki'] = 'media' }
-- return plugins
=======
  -- " Note Taking Plugins -----------------------------{{{
  { "preservim/vim-pencil" },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  --[[ { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' }, ]] -- replace by twilight and zenmode
  { 'dhruvasagar/vim-table-mode' },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
  {
    'tools-life/taskwiki',
    build = 'pip3 install --upgrade packaging && pip3 install --upgrade -r requirements.txt',
    dependencies = {
      'vimwiki/vimwiki',
    },
  },
  {
    'vimwiki/vimwiki',
    config = function()
      -- let g:vimwiki_ext2syntax = {}
    end,
  },
  { 'ekickx/clipboard-image.nvim', branch = 'main' },
  { "ellisonleao/glow.nvim" },
  { 'mickael-menu/zk-nvim' },
  { 'nullchilly/fsread.nvim' },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}

vim.g.vimwiki_ext2syntax = { ['.wiki'] = 'media' }
return require("lazy").setup(plugins, opts)
>>>>>>> c926e22 (Update nvim configs):nvim/lua/plugins/init.lua
