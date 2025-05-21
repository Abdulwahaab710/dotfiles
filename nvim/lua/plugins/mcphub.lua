return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest",  -- Installs required mcp-hub npm module
    config = function()
      require("mcphub").setup({
          extensions = {
              avante = {
                  make_slash_commands = true, -- make /slash commands from MCP server prompts
              }
          }
      })
    end,
  }
}
