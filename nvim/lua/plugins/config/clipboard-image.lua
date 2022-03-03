require'clipboard-image'.setup {
  default = {
    img_dir = 'img',
    img_dir_txt = 'img',
    img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
    affix = '%s'
  },
  markdown = {
    affix = '![](%s)'
  },
  vimwiki = {
    affix = '{{file:%s}}'
  }
}
