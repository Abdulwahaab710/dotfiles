local parsers = {
  'ruby', 'rust', 'javascript', 'html', 'css', 'json', 'sql',
  'lua', 'yaml', 'toml', 'dockerfile', 'bash', 'python',
  'git_config', 'gitignore', 'vim', 'vimdoc',
  'markdown', 'markdown_inline',
  'latex', 'regex', 'cmake', 'cpp', 'c',
  'tsx', 'typescript', 'go',
}

local filetypes = {
  'ruby', 'eruby', 'rust', 'javascript', 'javascriptreact',
  'html', 'css', 'json', 'sql',
  'lua', 'yaml', 'toml', 'dockerfile', 'bash', 'sh', 'python',
  'gitconfig', 'gitignore', 'vim', 'help',
  'markdown',
  'tex', 'cmake', 'cpp', 'c',
  'typescriptreact', 'typescript', 'go',
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function()
    local ok, ts = pcall(require, 'nvim-treesitter')
    if ok and type(ts.install) == 'function' then ts.install(parsers) end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    pcall(vim.treesitter.start)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require('nvim-autopairs').setup()
