vim.g.vimwiki_ext2syntax = { ['.wiki'] = 'media' }

return {
  -- " Note Taking Plugins -----------------------------{{{
  { 'junegunn/goyo.vim' },
  { 'junegunn/limelight.vim' },
  { 'dhruvasagar/vim-table-mode' },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
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
};
