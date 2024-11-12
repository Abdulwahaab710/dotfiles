return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
      "zidhuss/neotest-minitest",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run closest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        adapters = {
          require("neotest-rspec"),
          require("neotest-rust"),
          require("neotest-minitest"),
        },
      })
    end,

  },
}
