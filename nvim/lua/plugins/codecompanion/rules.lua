local M = {}

-- Find the project root directory by walking up the directory tree until a marker is found
function M.find_root_dir(file_path, root_markers)
  local root_dir = vim.fn.fnamemodify(file_path, ":h") -- Start with buffer directory

  -- Walk up the directory tree until we find a marker
  while root_dir ~= "/" do
    local found = false
    for _, marker in ipairs(root_markers) do
      if vim.fn.isdirectory(root_dir .. "/" .. marker) == 1 or vim.fn.filereadable(root_dir .. "/" .. marker) == 1 then
        found = true
        break
      end
    end

    if found then
      break
    end

    -- Move up one directory
    root_dir = vim.fn.fnamemodify(root_dir, ":h")
  end

  return root_dir
end

-- Parse frontmatter to extract glob patterns from a file's content
function M.parse_glob_patterns(content)
  local patterns = {}
  local in_frontmatter = false

  for _, line in ipairs(content) do
    if line:match("^%-%-%-$") then
      if in_frontmatter then
        break
      else
        in_frontmatter = true
      end
    elseif in_frontmatter then
      local globs = line:match("^globs:%s*(.+)$")
      if globs then
        -- Handle array format: globs: ["pattern1", "pattern2"]
        if globs:match("^%[.+%]$") then
          -- Remove [ and ]
          local globs_content = globs:sub(2, -2)
          -- handles both ' and "
          for pattern_match in globs_content:gmatch("[\"']([^\"']+)[\"']") do
            table.insert(patterns, pattern_match)
          end
        else
          -- Handle simple string format: globs: pattern, removes quotes if present
          local clean_glob = globs:gsub("^[\"'](.+)[\"']$", "%1")
          table.insert(patterns, clean_glob)
        end
        break
      end
    end
  end

  return patterns
end

-- Scan for rule files in the given directory and extract their patterns and content
function M.scan_rule_files(rules_dir)
  local files = {}
  local scan_files = vim.fn.glob(rules_dir .. "/*", false, true)

  for _, file in ipairs(scan_files) do
    if vim.fn.isdirectory(file) == 0 then
      local content = vim.fn.readfile(file)
      local patterns = M.parse_glob_patterns(content)

      if #patterns > 0 then
        local filtered_content = M.extract_content_after_frontmatter(content)
        table.insert(files, { file = file, patterns = patterns, content = filtered_content })
      else
        vim.api.nvim_echo({{"Warning: No glob patterns found in file: " .. file, "WarningMsg"}}, true, {})
      end
    end
  end

  return files
end

function M.extract_content_after_frontmatter(content)
  local frontmatter_end = 0

  -- Check if the file starts with frontmatter delimiter
  if content[1] and (content[1] == "---" or content[1] == "+++") then
    local delimiter = content[1]

    -- Find the end of the frontmatter
    for i = 2, #content do
      if content[i] == delimiter then
        frontmatter_end = i
        break
      end
    end
  end

  -- If frontmatter was found, return only the content after it
  if frontmatter_end > 0 then
    local result = {}
    for i = frontmatter_end + 1, #content do
      table.insert(result, content[i])
    end
    return result
  end

  -- If no frontmatter was found, return the original content
  return content
end

-- Get the content of files whose patterns match the current file
function M.get_matching_file_contents(files, file_name_from_root_dir)
  local file_contents = {}

  for _, file_entry in ipairs(files) do
    if file_entry.patterns then
      for _, pattern in ipairs(file_entry.patterns) do
        local is_match = vim.fn.glob(pattern):find(file_name_from_root_dir)
        if is_match then
          for _, line in ipairs(file_entry.content) do
            table.insert(file_contents, line)
          end

          -- found a match, no need to check other patterns
          break
        end
      end
    end
  end

  return file_contents
end

---@class CodeCompanionContext
---@field filename string Path to the current file

---@class CodeCompanionRulesOptions
---@field rules_dir? string Directory containing rule files (default: ".cursor/rules")
---@field root_markers? string[] Markers to identify the project root (default: {".git"})

---@param context CodeCompanionContext Context information with filename
---@param opts? CodeCompanionRulesOptions Configuration options
---@return string Content of matched rule files
function M.init(context, opts)
  opts = opts or {}
  local RULES_DIR = opts.rules_dir or ".cursor/rules"
  local ROOT_MARKERS = opts.root_markers or { ".git" }
  local file_name = context.filename

  local root_dir = M.find_root_dir(file_name, ROOT_MARKERS)

  local absolute_rules_dir = root_dir .. "/" .. RULES_DIR
  local file_name_from_root_dir = file_name:sub(#root_dir + 2)

  if vim.fn.isdirectory(absolute_rules_dir) == 0 then
    vim.api.nvim_err_writeln("Rules directory does not exist")
    return ""
  end

  local rule_files = M.scan_rule_files(absolute_rules_dir)
  if #rule_files == 0 then
    return ""
  end
  local file_contents = M.get_matching_file_contents(rule_files, file_name_from_root_dir)
  if #file_contents == 0 then
    return ""
  end

  local str = "Here is context for " .. file_name .. ":\n" .. table.concat(file_contents, "---\n")

  if #file_contents == 0 then
    return ""
  end
  return str
end

return M
