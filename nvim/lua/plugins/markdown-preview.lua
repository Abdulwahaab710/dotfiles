return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    -- build = function()
    --   vim.fn.system("which yarn")
    --   if vim.v.shell_error == 0 then
    --     return "cd app && yarn install"
    --   else
    --     return "cd app && npm install"
    --   end
    -- end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- use a custom Markdown style. Must be an absolute path
      -- like '/Users/username/markdown.css' or expand('~/markdown.css')
      vim.g.mkdp_markdown_css = vim.fn.expand("$HOME/.config/nvim/style/markdown.css")

      -- use a custom highlight style. Must be an absolute path
      -- like '/Users/username/highlight.css' or expand('~/highlight.css')
      vim.g.mkdp_highlight_css = vim.fn.expand("$HOME/.config/nvim/style/highlight.css")
    end,
    ft = { "markdown" },
  },
}
