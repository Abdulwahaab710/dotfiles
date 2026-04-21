vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'nvim-treesitter' then return end
    if ev.data.kind == 'update' then
      pcall(vim.cmd, 'TSUpdate')
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/windwp/nvim-autopairs',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  'https://github.com/nvim-treesitter/playground',
  'https://github.com/nvim-treesitter/nvim-treesitter-refactor',
  'https://github.com/RRethy/nvim-treesitter-endwise',
})

require('plugins_config.treesitter')
