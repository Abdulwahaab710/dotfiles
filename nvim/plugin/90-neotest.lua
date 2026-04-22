local loaded = false
local function load()
  if loaded then return end
  vim.pack.add({
    'https://github.com/antoinemadec/FixCursorHold.nvim',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/olimorris/neotest-rspec',
    'https://github.com/rouge8/neotest-rust',
    'https://github.com/zidhuss/neotest-minitest',
    'https://github.com/nvim-neotest/neotest',
  })
  require('neotest').setup({
    adapters = {
      require('neotest-rspec'),
      require('neotest-rust'),
      require('neotest-minitest'),
    },
  })
  loaded = true
end

vim.keymap.set('n', '<leader>tt', function()
  load()
  require('neotest').run.run()
end, { desc = 'Run closest test' })

vim.keymap.set('n', '<leader>tf', function()
  load()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run file' })
