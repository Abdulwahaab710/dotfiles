vim.cmd([[
let g:zettelkasten = "~/zettelkasten/"
command! NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . ".md"
au BufNewFile ~/zettelkasten/*.md 0r ~/src/github.com/Abdulwahaab710/dotfiles/nvim/template/zettel.md
]])
