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
    pattern = { vimwiki_pattern },
    command = "setlocal noswapfile",
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

vim.api.nvim_create_autocmd({ "VimLeave", "VimLeavePre" }, {
  callback = function(ev, opts)
    -- os.execute("kitty @ --to $KITTY_LISTEN_ON set-font-size '0'")
    os.execute("tmux set-option status on")
    os.execute("tmux list-panes -F '\\#F' | grep -q Z && tmux resize-pane -Z")
  end,
})
