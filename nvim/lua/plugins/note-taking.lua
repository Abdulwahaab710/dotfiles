local g = vim.g
g.vimwiki_ext2syntax = { ['.wiki'] = 'media' }
g.vimwiki_markdown_link_ext = 1
g.vimwiki_global_ext = 0
g.vimwiki_list = {
  -- {
  --   path = '~/vimwiki',
  --   syntax = 'media',
  --   ext = '.wiki',
  -- },
  {
    path = '~/vimwiki',
    syntax = 'markdown',
    ext = '.md',
  },
}
g.vimwiki_table_mappings = 0
g.vimwiki_filetypes = { "markdown" }

return {
  -- " Note Taking Plugins -----------------------------{{{
  { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' },
  { 'dhruvasagar/vim-table-mode' },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    config = function()
      -- disable the UI since we're using render-markdown.nvim
      -- https://github.com/MeanderingProgrammer/render-markdown.nvim?tab=readme-ov-file#obsidiannvim
      require('obsidian').setup({
        ui = { enable = false },
        workspaces = {
          {
            name = "personal",
            path = "$HOME/src/github.com/abdulwahaab710/zk-notes",
          },
          --[[ {
            name = "work",
            path = "$HOME/src/github.com/abdulwahaab710/zk-notes",
          }, ]]
        },
      })
    end
  },
  {
    'tools-life/taskwiki',
    build = 'pip3 install --upgrade packaging --break-system-packages && pip3 install --upgrade --break-system-packages -r requirements.txt',
    dependencies = {
      'vimwiki/vimwiki',
    },
  },
  {
    'vimwiki/vimwiki',
    config = function()
    end,
  },
  { 'ekickx/clipboard-image.nvim', branch = 'main' },
  { "ellisonleao/glow.nvim" },
  { 'mickael-menu/zk-nvim' },
  { 'nullchilly/fsread.nvim' },
  {
    'dawsers/edit-code-block.nvim',
    config = function()
      require('ecb').setup {
        wincmd = 'split', -- this is the default way to open the code block window
      }
    end
  }
};
