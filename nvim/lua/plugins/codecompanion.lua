local openai_key_path = vim.fn.expand("openai_key")

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "banjo/contextfiles.nvim",
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      },
    },
  },
  event = "BufEnter",
  cond = function()
    return vim.fn.executable(openai_key_path)
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "x" }, desc = "CodeCompanion Actions" },
    { "<leader>aC", "<cmd>CodeCompanionChat<cr>", mode = { "n", "x" }, desc = "CodeCompanion Chat" },
    { "<leader>ac", function ()
      require("codecompanion").prompt("cursorRules")
    end, mode = { "n", "x" }, desc = "CodeCompanion Chat" },
    { "<leader>ap", "<cmd>CodeCompanion<cr>", mode = { "n", "x" }, desc = "CodeCompanion in prompt" },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
    require("codecompanion").setup(require("plugins.codecompanion.config"))
  end,
}
