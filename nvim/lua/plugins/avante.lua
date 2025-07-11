local openai_key_path = vim.fn.expand("openai_key")
local provider
local vendors = {}

if vim.fn.executable(openai_key_path) == 1 then
  provider = "shopify-ai"
  vendors["shopify-ai"] = {
    __inherited_from = 'openai',
    endpoint = "https://proxy.shopify.ai/v1/",
    model = "anthropic:claude-3-5-sonnet",
    api_key_name = "cmd:openai_key cat",
  }
else
  provider = "copilot-sonnet"
  vendors["copilot-sonnet"] = {
    __inherited_from = 'copilot',
    model = "claude-3.7-sonnet",
  }
end

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    --[[ opts = {

      -- add any opts here
      -- for example
      provider = provider,
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },

      vendors = vendors,
    }, ]]
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    config = function()
      require("avante").setup({
          -- Dynamically generate system prompt including available MCP tools
          provider = provider,
          providers = vendors,
          system_prompt = function()
              local hub = require("mcphub").get_hub_instance()
              if hub and hub:is_ready() then
                  return hub:get_active_servers_prompt() -- Generates prompt listing active tools
              else
                  return "Default system prompt."
              end
          end,
          behaviour = {
            enable_token_counting = false,
            -- auto_suggestions = true, -- Experimental stage
            auto_apply_diff_after_generation = false,
            -- auto_approve_tool_permissions = { "replace_in_file" }
            auto_approve_tool_permissions = true
          },

          -- Define MCP interaction as a custom tool for Avante agents
          custom_tools = {
              require("mcphub.extensions.avante").mcp_tool()
          },
          mappings = {
            suggestion = {
              accept = "<M-l>",
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          }
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
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
  }
}
