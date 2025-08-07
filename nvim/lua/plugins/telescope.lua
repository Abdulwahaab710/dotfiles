return {
  {
    "nvim-telescope/telescope.nvim",

    config = function ()
      local present, telescope = pcall(require, "telescope")

      if not present then
        return
      end

      local default = {
        defaults = {
          find_files = {
            hidden = true,
          },
          file_browser = {
            extensions = {
              hijack_netrw = true,
            }
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = { "node_modules" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
        extensions = {
          fzf = {}
        }
      }
      telescope.setup(default)
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "fzf"

      if vim.fn.getcwd() == os.getenv("HOME") then
        -- redefine fzf call: vim.cmd( "let $FZF_DEFAULT_COMMAND ...
        vim.cmd("command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': []}, <bang>0)")

        vim.keymap.set("n", "<c-p>", ":FzfFiles<CR>", {});
      else
        -- redefine find_files: function custom_find_files() ...
          vim.keymap.set("n", "<c-p>", require('telescope.builtin').find_files, {});
        end
        vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})

        -- map \ to grep
        vim.keymap.set('n', '\\', require('telescope.builtin').live_grep, {})

        -- Rails shortcuts
        vim.keymap.set('n', '<leader>ff', function ()
          require('telescope.builtin').find_files({
            prompt_title = 'Find models',
            cwd = vim.fn.getcwd() .. '/test/fixtures'
          })
        end, {})
        vim.keymap.set('n', '<leader>fm', function ()
          require('telescope.builtin').find_files({
            prompt_title = 'Find models',
            cwd = vim.fn.getcwd() .. '/app/models'
          })
        end, {})
        vim.keymap.set('n', '<leader>fj', function ()
          require('telescope.builtin').find_files({
            prompt_title = 'Find jobs',
            cwd = vim.fn.getcwd() .. '/app/jobs'
          })
        end, {})
        vim.keymap.set('n', '<leader>fc', function ()
          require('telescope.builtin').find_files({
            prompt_title = 'Find controllers',
            cwd = vim.fn.getcwd() .. '/app/controllers'
          })
        end, {})
        vim.keymap.set('n', '<leader>fv', function ()
          require('telescope.builtin').find_files({
            prompt_title = 'Find views',
            cwd = vim.fn.getcwd() .. '/app/views'
          })
        end, {})
      end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require "telescope".load_extension("frecency")
      end,
      dependencies = { "kkharji/sqlite.lua" },
    },

  }
