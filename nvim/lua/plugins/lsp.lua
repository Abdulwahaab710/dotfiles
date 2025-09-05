--[[ -- Command to toggle inline diagnostics
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
vim.api.nvim_set_keymap('n', '<Leader>ii', ':lua vim.cmd("DiagnosticsToggleVirtualText")<CR>', { noremap = true, silent = true }) ]]

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rb",
  callback = function()
    vim.lsp.buf.format()
  end,
})

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts = {
      ensure_installed = {
        "rust-analyzer",
        -- "solargraph",
        -- "sorbet",
        "lua_ls",
        -- "shellcheck",
        "harper-ls",
        "basedpyright",
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
        -- solargraph = {},
        -- sorbet = {},
        lua_ls = {},
        ast_grep = {}
        -- shellcheck = {},
      }

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local function sorbet_root_pattern(...)
        local patterns = { "sorbet/config" }
        return require("lspconfig.util").root_pattern(unpack(patterns))(...)
      end

      require'lspconfig'.sorbet.setup({
        root_dir = function(fname)
          return sorbet_root_pattern(fname)
        end,
      })

      require'lspconfig'.lua_ls.setup {
          settings = {
              Lua = {
                  diagnostics = {
                      globals = { 'vim' }
                  }
              }
          }
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
        sources = {
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip'}
        },
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
  --[[ {
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
  }, ]]
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
        loadfile(ft_path)()
      end

      --[[ imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
      " -1 for jumping backwards.
      inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

      snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

      " For changing choices in choiceNodes (not strictly necessary for a basic setup).
      imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>' ]]
    end
  },
  -- {
  --   "folke/trouble.nvim",
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       "<leader>xx",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>xX",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  --
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "folke/lsp-colors.nvim",
  --   },
  --   config = function ()
  --     require("trouble").setup({
  --       auto_close = true, -- auto close when there are no items
  --       auto_open = true, -- auto open when there are items
  --     })
  --
  --   end
  -- },
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

      require('lspconfig').ast_grep.setup({
        -- these are the default options, you only need to specify
        -- options you'd like to change from the default
        cmd = { 'ast-grep', 'lsp' },
        filetypes = { "c", "cpp", "rust", "go", "java", "python", "javascript", "typescript", "html", "css", "kotlin", "dart", "lua", "ruby" },
        root_dir = require('lspconfig.util').root_pattern('sgconfig.yaml', 'sgconfig.yml')
      })

      require('lspconfig').lua_ls.setup {
        settings = {
         ["harper-ls"] = {
            userDictPath = "",
            fileDictPath = "",
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
              CorrectNumberSuffix = true
            },
            codeActions = {
              ForceStable = false
            },
            markdown = {
              IgnoreLinkTitle = false
            },
            diagnosticSeverity = "hint",
            isolateEnglish = false,
            dialect = "American",
            maxFileLength = 120000
          },
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }

      require("lspconfig").basedpyright.setup({
         settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })

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
          -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
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
    },
  },
  {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "LspAttach", -- Or `VeryLazy`
      priority = 1000, -- needs to be loaded in first
      config = function()
          require('tiny-inline-diagnostic').setup()
      end
  }
}
