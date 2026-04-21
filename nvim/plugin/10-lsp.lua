vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'mason.nvim' then
      vim.schedule(function() pcall(vim.cmd, 'MasonUpdate') end)
    elseif name == 'LuaSnip' then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  { src = 'https://github.com/VonHeikemen/lsp-zero.nvim', version = 'v3.x' },
  'https://github.com/ray-x/lsp_signature.nvim',
  'https://github.com/onsails/lspkind.nvim',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/saadparwaiz1/cmp_luasnip',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rb',
  callback = function() vim.lsp.buf.format() end,
})

require('plugins_config.luasnip')

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
  loadfile(ft_path)()
end

require('mason').setup()
require('lsp-zero').extend_lspconfig()

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
end)

require('lsp_signature').setup()

local mason_lspconfig = require('mason-lspconfig')
local servers = {
  ruby_lsp = {},
  rust_analyzer = {},
  lua_ls = {},
  ast_grep = {},
  semgrep = {},
}
mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

local function sorbet_root_pattern(...)
  local patterns = { 'sorbet/config' }
  return require('lspconfig.util').root_pattern(unpack(patterns))(...)
end

local lspconfig = require('lspconfig')

lspconfig.sorbet.setup({
  root_dir = function(fname) return sorbet_root_pattern(fname) end,
})

lspconfig.ast_grep.setup({
  cmd = { 'ast-grep', 'lsp' },
  filetypes = { 'c', 'cpp', 'rust', 'go', 'java', 'python', 'javascript', 'typescript', 'html', 'css', 'kotlin', 'dart', 'lua', 'ruby', 'erb' },
  root_dir = require('lspconfig.util').root_pattern('sgconfig.yaml', 'sgconfig.yml'),
})

lspconfig.semgrep.setup({ cmd = { 'semgrep lsp' } })

lspconfig.lua_ls.setup({
  settings = {
    ['harper-ls'] = {
      userDictPath = '',
      fileDictPath = '',
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongQuotes = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true,
      },
      codeActions = { ForceStable = false },
      markdown = { IgnoreLinkTitle = false },
      diagnosticSeverity = 'hint',
      isolateEnglish = false,
      dialect = 'American',
      maxFileLength = 120000,
    },
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
})

lspconfig.basedpyright.setup({
  settings = {
    basedpyright = { analysis = { typeCheckingMode = 'basic' } },
  },
})

local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'ShowRubyDeps', function(opts)
    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == 'all'
    client.request('rubyLsp/workspace/dependencies', params, function(error, result)
      if error then
        print('Error showing deps: ' .. error)
        return
      end
      local qf_list = {}
      for _, item in ipairs(result) do
        if showAll or item.dependency then
          table.insert(qf_list, {
            text = string.format('%s (%s) - %s', item.name, item.version, item.dependency),
            filename = item.path,
          })
        end
      end
      vim.fn.setqflist(qf_list)
      vim.cmd('copen')
    end, bufnr)
  end, { nargs = '?', complete = function() return { 'all' } end })
end

lspconfig.ruby_lsp.setup({
  on_attach = function(client, buffer) add_ruby_deps_command(client, buffer) end,
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local lspkind = require('lspkind')
lspkind.init()

cmp.setup({
  sources = {
    per_filetype = { codecompanion = { 'codecompanion' } },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }),
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind or '', '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '
      kind.menu = '    (' .. (strings[2] or '') .. ')'
      return kind
    end,
  },
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
})
