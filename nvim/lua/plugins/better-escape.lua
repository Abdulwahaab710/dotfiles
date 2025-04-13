return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup {
        timeout = vim.o.timeoutlen,
        default_mappings = false,
        mappings = {
            i = {
                j = {
                    -- These can all also be functions
                    k = "<Esc>",
                },
            },
            c = {
                j = {
                    k = "<Esc>",
                },
            },
            t = {
                j = {
                    k = "<C-\\><C-n>",
                },
            },
            -- v = {
            --     j = {
            --         k = "<Esc>",
            --     },
            -- },
            s = {
                j = {
                    k = "<Esc>",
                },
            },
        },
    }
  end,
}
