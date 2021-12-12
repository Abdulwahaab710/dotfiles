local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then return end

local has_cmp, cmp = pcall(require, 'cmp')
local lspkind = require('lspkind')


--[[ cmp.setup({
  snippet = {
    expand = function(args)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}) ]]

lspkind.init()

if has_cmp then
  cmp.setup {
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'vsnip' },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    },
    --[[ completion = {
      keyword_length = 3,
    }, ]]
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end
    },
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          vsnip = "[snip]",
        },
      },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        -- cmp.config.compare.kind places snippets above other types.
        -- I prefer to have snippets listed last.
        function(entry1, entry2)
          return cmp.config.compare.kind(entry2, entry1)
        end,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  }
end


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--[[ cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
}) ]]

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--[[ cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
}) ]]

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
  -- Redraw the tab line as soon as possible, so LSP client statuses show up;
  -- instead of waiting until the first time they publish a progress message.
  vim.cmd('redrawtabline')
end
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 500,
}


local servers = {
  -- 'pyright',
  -- 'gopls',
  'rust_analyzer',
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end

lspconfig.solargraph.setup {
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  capabilities = capabilities,
}

lspconfig.sorbet.setup {
  cmd = {"bundle", "exec", "srb", "tc", "--lsp"},
  capabilities = capabilities,
}
lspconfig['null-ls'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
})

