return {
  -- " git plugins -------------------------------------{{{
    { 'lewis6991/gitsigns.nvim', branch = 'main' },
    -- " }}}

    -- " tpope plugins -----------------------------------{{{
      -- { 'tpope/vim-surround' }, -- " easily surround things...just read docs for info
      { 'tpope/vim-dispatch' },
      { 'tpope/vim-dadbod' },
      { 'tpope/vim-eunuch' },
      { 'tpope/vim-fugitive' },
      { 'tpope/vim-rhubarb' },
      { 'tpope/vim-projectionist' },
      -- " }}}

      -- " misc --------------------------------------------{{{
        -- {
        --   "kylechui/nvim-surround",
        --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
        --   event = "VeryLazy",
        --   config = function()
        --     require("nvim-surround").setup({
        --       -- Configuration here, or leave empty to use defaults
        --       keymaps = {
        --         insert = "<C-g>s",
        --         insert_line = "<C-g>S",
        --         normal = "ys",
        --         normal_cur = "yss",
        --         normal_line = "yS",
        --         normal_cur_line = "ySS",
        --         visual = "S",
        --         visual_line = "gS",
        --         delete = "ds",
        --         change = "cs",
        --         change_line = "cS",
        --       }
        --     })
        --   end
        -- },
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
          -- dir = '~/.fzf',
          -- build = './install --all',
          build = 'fzf#install()',
          dependencies = {
            'junegunn/fzf.vim'
          },
        },
        -- Optional for icons.
        { "nvim-tree/nvim-web-devicons" },
        -- Optional for 'fzf' command.
        {
          "junegunn/fzf",
          build = function()
            vim.fn["fzf#install"]()
          end,
        },

        {
          "linrongbin16/fzfx.nvim",
          -- Optional to avoid break changes between major versions.
          version = "v7.*",
          dependencies = { "nvim-tree/nvim-web-devicons", 'junegunn/fzf' },
          config = function()
            require("fzfx").setup()
          end,
        },
        { 'nvim-lua/popup.nvim' },
        { 'liuchengxu/vista.vim' },
        { 'xolox/vim-misc' },
        { 'mbbill/undotree' },
        -- { 'janko-m/vim-test' },
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

        }
