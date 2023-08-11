local vimwiki_group = vim.api.nvim_create_augroup("VimWiki", { clear = true })

local vimwiki_pattern = vim.fn.expand("$HOME/vimwiki/diary/") .. "*.wiki"
vim.api.nvim_create_autocmd(
  "BufNewFile",
  {
    pattern = { vimwiki_pattern },
    command = "silent 0r !~/.config/bin/diary-template-generator/target/debug/diary-template-generator '%' ",
    group = vimwiki_group
  }
)

vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  {
    pattern = { vim.fn.expand("~/vimwiki/diary/diary.wiki") },
    command = "VimwikiDiaryGenerateLinks",
    group = vimwiki_group
  }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ejson" },
  command = "set ft=json",
  group = vim.api.nvim_create_augroup("ejson", { clear = true })
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
