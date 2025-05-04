local openai_cmd = "cmd:openai_key cat"
local openai = require("codecompanion.adapters.openai")
local openai_key_path = vim.fn.expand("openai_key")

local function adapter(base_name, url, model)
  local base = require("codecompanion.adapters." .. base_name)

  return require("codecompanion.adapters").extend(base_name, {
    url = url,
    env = {
      api_key = openai_cmd,
    },
    handlers = openai.handlers,
    headers = openai.headers,
    parameters = {
      model = "${model}",
    },
    schema = {
      model = {
        default = model or base.schema.model.default,
      },
    },
  })
end


local setup = {
  prompt_library = {
    ["Cursor Rules"] = {
      strategy = "chat",
      description = "Chat with cursor rules",
      opts = {
        -- ...
        short_name = "cursorRules"
      },
      prompts = {
        {
          role = "system",
          --[[ opts = {
            contains_code = true,
          }, ]]
          content = function(context)
            local ctx = require("contextfiles.extensions.codecompanion")

            local ctx_opts = { }
            local format_opts = { }

            return ctx.get(context.filename, ctx_opts, format_opts)
          end,
        },
        {
          role = "user",
          opts = {
            contains_code = true,
          },
          content = ""
        }
      },
    }
  },
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  },
  strategies = {
    chat = {
      slash_commands = {
        ["file"] = {
          -- Location to the slash command in CodeCompanion
          callback = "strategies.chat.slash_commands.file",
          description = "Select a file using Telescope",
          opts = {
            provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
            contains_code = true,
          },
        },
      },
    },
  },
}

if vim.fn.executable(openai_key_path) == 1 then
  setup["adapters"]= {
    opts = {
      show_defaults = false,
    },
    anthropic = adapter("anthropic", "https://proxy.shopify.ai/v1/chat/completions", "anthropic:claude-3-7-sonnet"),
    gemini = adapter("gemini", "https://proxy.shopify.ai/v1/chat/completions", "google:gemini-1.5-flash"),
    huggingface = adapter(
      "huggingface",
      "https://proxy.shopify.ai/v1/chat/completions",
      "huggingface:meta-llama/Meta-Llama-3.1-70B-Instruct"
    ),
    openai = adapter("openai", "https://proxy.shopify.ai/vendors/openai/v1/chat/completions"),
  }
  setup["strategies"] = {
    chat = {
      adapter = "shopify-ai",
    },
    inline = {
      adapter = "shopify-ai",
    },
  }
end

return setup

