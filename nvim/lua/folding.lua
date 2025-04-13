-- Source: https://www.jmaguire.tech/posts/treesitter_folding/

local api = vim.api
local folding_group = api.nvim_create_augroup("Folding", { clear = true })

api.nvim_create_autocmd(
    "BufWinEnter",
    {
        pattern = { "*.md", "*.wiki" },
        callback = function()
            if vim.bo.filetype == "vimwiki" or vim.bo.filetype == "markdown" then
                vim.cmd("normal zR")
            end
        end,
        group = folding_group
    }
)

api.nvim_create_autocmd(
    "FileType",
    {
        pattern = { "vimwiki", "markdown" },
        callback = function()
            vim.opt_local.foldmethod = "expr"
        end,
        group = folding_group
    }
)
