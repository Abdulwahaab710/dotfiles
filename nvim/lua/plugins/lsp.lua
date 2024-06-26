-- Command to toggle inline diagnostics
vim.api.nvim_create_user_command(
'DiagnosticsToggleVirtualText',
function()
  local current_value = vim.diagnostic.config().virtual_text
  if current_value then
    vim.diagnostic.config({virtual_text = false})
  else
    vim.diagnostic.config({virtual_text = true})
  end
end,
{}
)

-- Keybinding to toggle inline diagnostics (ii)
vim.api.nvim_set_keymap('n', '<Leader>ii', ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>', { noremap = true, silent = true })

return {
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "solargraph",
        "sorbet",
        "lua_ls"
      }
    },
    config = function()
      require("mason").setup()
      require('lsp-zero').extend_lspconfig()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local mason_lspconfig = require("mason-lspconfig")
      local servers = {
        ruby_lsp = {},
        rust_analyzer = {},
        solargraph = {},
        sorbet = {},
        lua_ls = {}
      }

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },
    config = function ()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({select = false}),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
          end,
        },

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

    end

  },
  --  { 'hrsh7th/cmp-cmdline' },
  { 'github/copilot.vim' },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip'
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },

    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
    config = function ()
      require("trouble").setup({
        auto_close = true, -- auto close when there are no items
        auto_open = true, -- auto open when there are items
      })

    end
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch="v3.x",
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false

        })
      end)

      require "lsp_signature".setup(cfg)

      local function add_ruby_deps_command(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
          local params = vim.lsp.util.make_text_document_params()
          local showAll = opts.args == "all"

          client.request("rubyLsp/workspace/dependencies", params, function(error, result)
            if error then
              print("Error showing deps: " .. error)
              return
            end

            local qf_list = {}
            for _, item in ipairs(result) do
              if showAll or item.dependency then
                table.insert(qf_list, {
                  text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
                  filename = item.path
                })
              end
            end

            vim.fn.setqflist(qf_list)
            vim.cmd('copen')
          end, bufnr)
        end,
        {nargs = "?", complete = function() return {"all"} end})
      end


      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
      }
      )

      require("lspconfig").ruby_lsp.setup({
        on_attach = function(client, buffer)
          add_ruby_deps_command(client, buffer)
        end,
      })

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      local lspkind = require('lspkind')
      lspkind.init()

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
          end,
        },

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "ray-x/lsp_signature.nvim",
      "onsails/lspkind.nvim"
      -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    },
  }

}
