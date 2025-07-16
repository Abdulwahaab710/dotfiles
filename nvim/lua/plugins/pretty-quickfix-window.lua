return {
  "yorickpeterse/nvim-pqf",
  config = function()
    require('pqf').setup({
      signs = {
        error = { text = 'E', hl = 'DiagnosticSignError' },
        warning = { text = 'W', hl = 'DiagnosticSignWarn' },
        info = { text = 'I', hl = 'DiagnosticSignInfo' },
        hint = { text = 'H', hl = 'DiagnosticSignHint' },
      },

      -- By default, only the first line of a multi line message will be shown.
      -- When this is true, multiple lines will be shown for an entry, separated by
      -- a space
      show_multiple_lines = false,

      -- How long filenames in the quickfix are allowed to be. 0 means no limit.
      -- Filenames above this limit will be truncated from the beginning with
      -- `filename_truncate_prefix`.
      max_filename_length = 0,

      -- Prefix to use for truncated filenames.
      filename_truncate_prefix = '[...]',
    })
  end
}
