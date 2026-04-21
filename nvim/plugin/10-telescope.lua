vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name ~= 'telescope-fzf-native.nvim' then return end
    if ev.data.kind == 'install' or ev.data.kind == 'update' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/kkharji/sqlite.lua',
  'https://github.com/nvim-telescope/telescope-frecency.nvim',
})

local telescope = require('telescope')

telescope.setup({
  defaults = {
    find_files = { hidden = true },
    file_browser = { extensions = { hijack_netrw = true } },
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
  },
  pickers = {
    find_files = { hidden = true },
  },
  extensions = { fzf = {} },
})

telescope.load_extension('file_browser')
telescope.load_extension('fzf')
telescope.load_extension('frecency')

if vim.fn.getcwd() == os.getenv('HOME') then
  vim.cmd("command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': []}, <bang>0)")
  vim.keymap.set('n', '<c-p>', ':FzfFiles<CR>', {})
else
  vim.keymap.set('n', '<c-p>', require('telescope.builtin').find_files, {})
end

vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '\\', require('telescope.builtin').live_grep, {})

vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find models',
    cwd = vim.fn.getcwd() .. '/test/fixtures',
  })
end, {})
vim.keymap.set('n', '<leader>fm', function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find models',
    cwd = vim.fn.getcwd() .. '/app/models',
  })
end, {})
vim.keymap.set('n', '<leader>fj', function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find jobs',
    cwd = vim.fn.getcwd() .. '/app/jobs',
  })
end, {})
vim.keymap.set('n', '<leader>fc', function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find controllers',
    cwd = vim.fn.getcwd() .. '/app/controllers',
  })
end, {})
vim.keymap.set('n', '<leader>fv', function()
  require('telescope.builtin').find_files({
    prompt_title = 'Find views',
    cwd = vim.fn.getcwd() .. '/app/views',
  })
end, {})
