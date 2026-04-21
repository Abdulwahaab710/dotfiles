vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' })
    require('tiny-inline-diagnostic').setup()
  end,
})
