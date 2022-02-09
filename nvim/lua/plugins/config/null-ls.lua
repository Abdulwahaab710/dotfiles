local nls = require('null-ls')
local helpers = require('null-ls.helpers')
local use_bundler_cache = {}
local lsp = vim.lsp

local M = {}

local function cached(table, key, func)
  if table[key] == nil then
    table[key] = func()
  end

  return table[key]
end

function M.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  local kind = stat and stat.type

  return kind == 'file'
end

function M.read(path, remove_trailing_newline)
  local file = assert(io.open(path, 'r'), 'Failed to open ' .. path)
  local data = file:read('*all')

  file:close()

  if remove_trailing_newline and data:sub(#data, #data) == '\n' then
    data = data:sub(1, #data - 1)
  end

  return data
end

local function use_bundler(gem, lockfile)
  if not M.file_exists(lockfile) then
    return 1
  end

  if M.read(lockfile, true):match(' ' .. gem .. ' ') ~= nil then
    return 2
  end

  return 0
end

local function root_path(client_id, path)
  local client = lsp.get_client_by_id(client_id)
  local root = client.config.root_dir or uv.cwd()

  return table.concat({ root, path }, '/')
end

local function rubocop_with_bundler(client_id)
  return cached(use_bundler_cache, client_id, function()
    return use_bundler('rubocop', root_path(client_id, 'Gemfile.lock'))
  end)
end

local function rubocop()
  local base_args = nls.builtins.diagnostics.rubocop._opts.args

  return nls.builtins.diagnostics.rubocop.with({
    command = function(params)
      if rubocop_with_bundler(params.client_id) == 2 then
        return "bundle"
      end

      return "rubocop"
    end,
    args = function(params)
      local args = base_args

      if rubocop_with_bundler(params.client_id) == 2 then
        args = vim.list_extend({ 'exec', 'rubocop' }, args)
      end

      return args
    end,
    --[[ runtime_condition = function(params)
      return rubocop_with_bundler(params.client_id) > 0
    end, ]]
  })
end


nls.setup({
  debounce = 1000,
  log = {
    level = 'error',
    use_console = false,
  },
  debug = true,
  sources = {
    nls.builtins.diagnostics.write_good,
    nls.builtins.code_actions.gitsigns,
    nls.builtins.formatting.prettier,
    nls.builtins.formatting.mix,
    nls.builtins.formatting.rubocop,
    nls.builtins.diagnostics.rubocop,
    -- rubocop(),
  },
  update_on_insert = false,
})
