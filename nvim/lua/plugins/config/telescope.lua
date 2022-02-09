-- require("todo-comments").setup {
--   signs = true, -- show icons in the signs column
--   -- keywords recognized as todo comments
--   keywords = {
--     FIX = {
--       icon = " ", -- icon used for the sign, and in search results
--       color = "error", -- can be a hex color, or a named color (see below)
--       alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
--       -- signs = false, -- configure signs for some keywords individually
--     },
--     TODO = { icon = " ", color = "info" },
--     HACK = { icon = " ", color = "warning" },
--     WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
--     PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
--     NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
--     DONE = { icon = "", color = "hint" }
--   },
--   -- highlighting of the line containing the todo comment
--   -- * before: highlights before the keyword (typically comment characters)
--   -- * keyword: highlights of the keyword
--   -- * after: highlights after the keyword (todo text)
--   highlight = {
--     before = "", -- "fg" or "bg" or empty
--     keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
--     after = "fg", -- "fg" or "bg" or empty
--     pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
--     comments_only = true, -- uses treesitter to match keywords in comments only
--   },
--   -- list of named colors where we try to extract the guifg from the
--   -- list of hilight groups or use the hex color if hl not found as a fallback
--   colors = {
--     error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
--     warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
--     info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
--     hint = { "LspDiagnosticsDefaultHint", "#10B981" },
--     default = { "Identifier", "#7C3AED" },
--   },
--   search = {
--     command = "rg",
--     args = {
--       "--color=never",
--       "--no-heading",
--       "--with-filename",
--       "--line-number",
--       "--column",
--     },
--     -- regex that will be used to match keywords.
--     -- don't replace the (KEYWORDS) placeholder
--     pattern = [[\b(KEYWORDS):]], -- ripgrep regex
--     -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
--   },
-- }

local present, telescope = pcall(require, "telescope")

if not present then
   return
end

local default = {
   defaults = {
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
}
telescope.setup(default)
--
-- local M = {}
-- M.setup = function(override_flag)
--    if override_flag then
--       default = require("core.utils").tbl_override_req("telescope", default)
--    end
--
--    telescope.setup(default)
--
--    local extensions = { "themes", "terms" }
--
--    pcall(function()
--       for _, ext in ipairs(extensions) do
--          telescope.load_extension(ext)
--       end
--    end)
-- end
--
-- return M
