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
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/ray-x/lsp_signature.nvim',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
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
require('mason-tool-installer').setup({
  ensure_installed = { 'tree-sitter-cli' },
  run_on_start = true,
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<CR>']      = { 'accept', 'fallback' },
    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-u>']     = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>']     = { 'scroll_documentation_down', 'fallback' },
    ['<C-b>']     = { 'snippet_backward', 'fallback' },
  },
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'buffer', 'path', 'snippets' },
    per_filetype = { codecompanion = { 'codecompanion' } },
    providers = {
      codecompanion = {
        name = 'CodeCompanion',
        module = 'codecompanion.providers.completion.blink',
      },
    },
  },
  appearance = { nerd_font_variant = 'mono' },
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { 'utf-16' }

vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.config('sorbet', {
  root_dir = function(bufnr, cb)
    local root = vim.fs.root(bufnr, { 'sorbet/config' })
    if root then cb(root) end
  end,
})

vim.lsp.config('ast_grep', {
  cmd = { 'ast-grep', 'lsp' },
  filetypes = { 'c', 'cpp', 'rust', 'go', 'java', 'python', 'javascript', 'typescript', 'html', 'css', 'kotlin', 'dart', 'lua', 'ruby', 'erb' },
  root_dir = function(bufnr, cb)
    local root = vim.fs.root(bufnr, { 'sgconfig.yaml', 'sgconfig.yml' })
    if root then cb(root) end
  end,
})

vim.lsp.config('semgrep', { cmd = { 'semgrep', 'lsp' } })

vim.lsp.config('lua_ls', {
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

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = { analysis = { typeCheckingMode = 'basic' } },
  },
})

local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'ShowRubyDeps', function(opts)
    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == 'all'
    client:request('rubyLsp/workspace/dependencies', params, function(error, result)
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

vim.lsp.config('ruby_lsp', {
  on_attach = function(client, bufnr) add_ruby_deps_command(client, bufnr) end,
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'ruby_lsp',
    'rust_analyzer',
    'lua_ls',
    'ast_grep',
    'semgrep',
    'sorbet',
    'basedpyright',
  },
  automatic_enable = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n',       'K',     vim.lsp.buf.hover,                                   opts)
    vim.keymap.set('n',       'gd',    vim.lsp.buf.definition,                              opts)
    vim.keymap.set('n',       'gD',    vim.lsp.buf.declaration,                             opts)
    vim.keymap.set('n',       'gi',    vim.lsp.buf.implementation,                          opts)
    vim.keymap.set('n',       'go',    vim.lsp.buf.type_definition,                         opts)
    vim.keymap.set('n',       'gr',    vim.lsp.buf.references,                              opts)
    vim.keymap.set('n',       'gs',    vim.lsp.buf.signature_help,                          opts)
    vim.keymap.set('n',       '<F2>',  vim.lsp.buf.rename,                                  opts)
    vim.keymap.set({'n','x'}, '<F3>',  function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n',       '<F4>',  vim.lsp.buf.code_action,                             opts)
    vim.keymap.set('n',       'gl',    vim.diagnostic.open_float,                           opts)
  end,
})

require('lsp_signature').setup()
