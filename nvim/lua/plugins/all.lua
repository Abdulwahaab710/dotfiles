-- " Code Completion and snippets --------------------{{{
return {
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
  { "rebelot/kanagawa.nvim" },
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
