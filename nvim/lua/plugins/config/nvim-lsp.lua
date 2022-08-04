local has_lspconfig, lspconfig = pcall(require, 'lspconfig')

if not has_lspconfig then return end

local has_cmp, cmp = pcall(require, 'cmp')
local lspkind = require('lspkind')
lspkind.init()

if has_cmp then
  cmp.setup {
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = "path" },
      { name = "buffer" },
    },
    --[[ completion = {
      keyword_length = 3,
    }, ]]
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[API]",
          path = "[PATH]",
          luasnip = "[SNIP]",
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


require("lsp_lines").setup()
vim.diagnostic.config({
  virtual_text = false,
})

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
  require "lsp_signature".on_attach()
  vim.cmd([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()]])
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
if not configs.ruby_lsp then
  configs.ruby_lsp = {
    default_config = {
      cmd = {'bundle', 'exec', 'ruby-lsp'};
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
  'rubocop_lsp',
  'ruby_lsp'
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

lspconfig.ruby_lsp.setup{}
--[[ lspconfig['null-ls'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = flags,
}) ]]

