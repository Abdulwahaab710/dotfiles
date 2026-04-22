vim.pack.add({
  'https://github.com/junegunn/goyo.vim',
  'https://github.com/junegunn/limelight.vim',
  'https://github.com/dhruvasagar/vim-table-mode',
  { src = 'https://github.com/epwalsh/obsidian.nvim', version = vim.version.range('*') },
  { src = 'https://github.com/ekickx/clipboard-image.nvim', version = 'main' },
  'https://github.com/ellisonleao/glow.nvim',
  'https://github.com/mickael-menu/zk-nvim',
  'https://github.com/nullchilly/fsread.nvim',
  'https://github.com/dawsers/edit-code-block.nvim',
  'https://github.com/opdavies/toggle-checkbox.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/vimwiki/vimwiki',
  { src = 'https://github.com/Pocco81/TrueZen.nvim', version = 'main' },
})

require('plugins_config.true-zen')

require('plugins_config.vimwiki')
require('plugins_config.zk')
require('plugins_config.clipboard-image')

require('obsidian').setup({
  ui = { enable = false },
  workspaces = {
    {
      name = 'personal',
      path = '$HOME/src/github.com/abdulwahaab710/zk-notes',
    },
  },
})

require('ecb').setup({ wincmd = 'split' })

require('render-markdown').setup({
  nested = false,
  file_types = { 'markdown', 'vimwiki', 'codecompanion' },
  render_modes = { 'n', 'no', 'c', 't', 'i', 'ic' },
  heading = {
    width = 'block',
    backgrounds = {
      'MiniStatusLineModeNormal',
      'MiniStatusLineModeInsert',
      'MiniStatusLineModeReplace',
      'MiniStatusLineModeVisual',
      'MiniStatusLineModeCommand',
      'MiniStatusLineModeOther',
    },
    sign = false,
    left_pad = 1,
    right_pad = 0,
    position = 'right',
    icons = { '', '', '', '', '', '' },
  },
  code = { disable_background = { 'markdown' } },
  backgrounds = {
    'RenderMarkdownH1Bg',
    'RenderMarkdownH2Bg',
    'RenderMarkdownH3Bg',
    'RenderMarkdownH4Bg',
    'RenderMarkdownH5Bg',
    'RenderMarkdownH6Bg',
  },
  foregrounds = {
    'RenderMarkdownH1',
    'RenderMarkdownH2',
    'RenderMarkdownH3',
    'RenderMarkdownH4',
    'RenderMarkdownH5',
    'RenderMarkdownH6',
  },
  checkbox = {
    enabled = true,
    position = 'inline',
    unchecked = {
      icon = '󰄱 ',
      highlight = 'RenderMarkdownUnchecked',
      scope_highlight = nil,
    },
    checked = {
      icon = '󰱒 ',
      highlight = 'RenderMarkdownChecked',
      scope_highlight = '@markup.strikethrough',
    },
    custom = {
      started = { raw = '[S]', rendered = '󰦕 ', highlight = 'RenderMarkdownWarn', scope_highlight = nil },
      deleted = { raw = '[D]', rendered = ' ', highlight = 'RenderMarkdownError', scope_highlight = '@markup.strikethrough' },
      blocked = { raw = '[B]', rendered = '󰲼 ', highlight = 'RenderMarkdownError', scope_highlight = '@markup.strikethrough' },
    },
  },
  callout = {
    note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
    tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
    important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
    warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
    caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
    abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
    summary = { raw = '[!SUMMARY]', rendered = '󰨸 Summary', highlight = 'RenderMarkdownInfo' },
    tldr = { raw = '[!TLDR]', rendered = '󰨸 Tldr', highlight = 'RenderMarkdownInfo' },
    info = { raw = '[!INFO]', rendered = '󰋽 Info', highlight = 'RenderMarkdownInfo' },
    todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
    hint = { raw = '[!HINT]', rendered = '󰌶 Hint', highlight = 'RenderMarkdownSuccess' },
    idea = { raw = '[!IDEA]', rendered = '󰌶 Idea', highlight = 'RenderMarkdownSuccess' },
    success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
    check = { raw = '[!CHECK]', rendered = '󰄬 Check', highlight = 'RenderMarkdownSuccess' },
    done = { raw = '[!DONE]', rendered = '󰄬 Done', highlight = 'RenderMarkdownSuccess' },
    question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
    help = { raw = '[!HELP]', rendered = '󰘥 Help', highlight = 'RenderMarkdownWarn' },
    faq = { raw = '[!FAQ]', rendered = '󰘥 Faq', highlight = 'RenderMarkdownWarn' },
    attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn' },
    failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
    fail = { raw = '[!FAIL]', rendered = '󰅖 Fail', highlight = 'RenderMarkdownError' },
    missing = { raw = '[!MISSING]', rendered = '󰅖 Missing', highlight = 'RenderMarkdownError' },
    danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
    error = { raw = '[!ERROR]', rendered = '󱐌 Error', highlight = 'RenderMarkdownError' },
    bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
    example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
    quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
    cite = { raw = '[!CITE]', rendered = '󱆨 Cite', highlight = 'RenderMarkdownQuote' },
  },
})
vim.treesitter.language.register('markdown', 'vimwiki')

pcall(function()
  require('obsidian').get_client().opts.ui.enable = false
  local namespaceID = vim.api.nvim_get_namespaces()['ObsidianUI']
  if namespaceID then
    vim.api.nvim_buf_clear_namespace(0, namespaceID, 0, -1)
  end
end)

vim.keymap.set('n', '<space><space>', ":lua require('toggle-checkbox').toggle()<CR>")
