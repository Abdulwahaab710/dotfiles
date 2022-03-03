local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then return end

local has_cmp, cmp = pcall(require, 'cmp')
local lspkind = require('lspkind')
lspkind.init()

if has_cmp then
  cmp.setup {
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    },
    --[[ completion = {
      keyword_length = 3,
    }, ]]
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require'luasnip'.lsp_expand(args.body)
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
          luasnip = "[snip]",
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
  if client.name ~= 'null-ls' then
    client.resolved_capabilities.document_formatting = false
  end
  vim.cmd([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]])
end
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 500,
}

local configs = require 'lspconfig.configs'
if not configs.rubocop_lsp then
 configs.rubocop_lsp = {
   default_config = {
     cmd = {'bundle', 'exec', 'rubocop-lsp'};
     filetypes = {'ruby'};
     root_dir = function(fname)
       return lspconfig.util.find_git_ancestor(fname)
     end;
     settings = {};
   };
 }
end

local servers = {
  -- 'pyright',
  -- 'gopls',
  'rust_analyzer',
  'tsserver',
  'rubocop_lsp'
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities
  }
end

lspconfig.solargraph.setup {
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sorbet.setup {
  cmd = {"bundle", "exec", "srb", "tc", "--lsp"},
  on_attach = on_attach,
  capabilities = capabilities,
}
--[[ lspconfig['null-ls'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}) ]]

