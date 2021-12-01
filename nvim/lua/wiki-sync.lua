local api = vim.api

local commit = function()
  local filetype = vim.bo.filetype
  if filetype ~= 'vimwiki' then
    return
  end

  local current_filename = api.nvim_buf_get_name('%')
  -- Add all changes
  -- Commit all changes
  -- Push all changes
end

local pull = function()
  local filetype = vim.bo.filetype
  if filetype ~= 'vimwiki' then
    return
  end

  -- pull from origin master/main
end
