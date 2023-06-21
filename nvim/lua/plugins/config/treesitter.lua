require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "ruby", "rust", "javascript", "html", "css", "json", "sql", "lua", "yaml", "toml", "dockerfile", "bash", "python",
    "git_config", "gitignore", "vim", "markdown", "latex", "regex", "cmake", "cpp", "c", "tsx", "typescript",
    "go"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  matchup = {
    enable = true
  }
}

local npairs = require('nvim-autopairs')
local endwise = require('nvim-autopairs.ts-rule').endwise

npairs.setup()
npairs.add_rules({
  endwise('def .*$', 'end', 'ruby', 'method_name')
})
