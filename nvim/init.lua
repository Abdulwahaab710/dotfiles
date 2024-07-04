local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.g.mapleader = ";"
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  import = "plugins",
  change_detection = {
    notify = false,
  },
})

require('settings')
require('autocmd')
require('remap')
require('plugins_config')
require('theme')
require('colors')
