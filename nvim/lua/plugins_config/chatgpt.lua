if vim.fn.executable(vim.fn.expand("openai_key")) == 1 then
  require("chatgpt").setup({
    api_key_cmd = "openai_key cat"
  })
end
