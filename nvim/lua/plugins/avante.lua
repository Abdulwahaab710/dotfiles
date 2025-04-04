CUSTOM_TOOLS = {
  {
    name = "run_go_tests",  -- Unique name for the tool
    description = "Run Go unit tests and return results",  -- Description shown to AI
    command = "go test -v ./...",  -- Shell command to execute
    param = {  -- Input parameters (optional)
      type = "table",
      fields = {
        {
          name = "target",
          description = "Package or directory to test (e.g. './pkg/...' or './internal/pkg')",
          type = "string",
          optional = true,
        },
      },
    },
    returns = {  -- Expected return values
      {
        name = "result",
        description = "Result of the fetch",
        type = "string",
      },
      {
        name = "error",
        description = "Error message if the fetch was not successful",
        type = "string",
        optional = true,
      },
    },
    func = function(params, on_log, on_complete)  -- Custom function to execute
      local target = params.target or "./..."
      return vim.fn.system(string.format("go test -v %s", target))
    end,
  },
}

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function()
      local openai = require("avante.providers.openai")

      require("avante").setup({
        -- @type AvanteProvider
        --[[ provider = "shopify-ai",
        vendors = {
          ["shopify-ai"] = {
            endpoint = "https://proxy.shopify.ai/v3/v1",
            model = "anthropic:claude-3-5-sonnet",
            api_key_name = "cmd:openai_key cat",
            parse_curl_args = openai.parse_curl_args,
            parse_response_data = openai.parse_response,
          },
        },
        custom_tools = CUSTOM_TOOLS, ]]
      })
    end,
  }
}
