-- Source: https://www.jmaguire.tech/posts/treesitter_folding/

local api = vim.api
local folding_group = api.nvim_create_augroup("Folding", { clear = true })

api.nvim_create_autocmd(
    "BufWinEnter",
    {
        pattern = { "*" },
        command = "normal zR",
        group = folding_group
    }
)
vim.opt.foldmethod     = "expr"
