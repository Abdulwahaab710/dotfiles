-- local openai_cmd = "cmd:openai_key cat"
local openai = require("codecompanion.adapters.openai")
local openai_key_path = vim.fn.expand("openai_key")

--[[ local function adapter(base_name, url, model)
  local base = require("codecompanion.adapters." .. base_name)

  return require("codecompanion.adapters").extend(base_name, {
    env = {
      url = url,
      -- chat_url = "/v1/chat/completions",
      api_key = "",
    },
    handlers = openai.handlers,
    headers = openai.headers,
    parameters = {
      model = "${model}",
    },
    schema = {
      model = {
        default = model or base.schema.model.default,
      },
    },
  })
end ]]

    local function adapter(options)
      local base = require("codecompanion.adapters." .. options.name)
      local openai = require("codecompanion.adapters.openai")
      local default_model = options.default_model or base.schema.model.default

      return require("codecompanion.adapters").extend(base, {
        url = options.url,
        env = {
          api_key = openai_cmd,
        },
        handlers = openai.handlers,
        headers = openai.headers,
        parameters = {
          model = "${model}",
        },
        schema = {
          model = {
            default = default_model,
            choices = options.choices or { default_model },
          },
        },
      })
    end

    -- return {
    --   },


  local setup = {
    adapter = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
              choices = {
                "claude-3.7-sonnet",
                "claude-3.7-sonnet-thought",
                "claude-sonnet-4",
                "gpt-4.1",
                "o4-mini",
                "gemini-2.5-pro",
              },
            },
          },
        })
      end,
    },
    extensions = {
    contextfiles = {
      opts = {},
    },
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        show_result_in_chat = true,  -- Show mcp tool results in chat
        make_vars = true,            -- Convert resources to #variables
        make_slash_commands = true,  -- Add prompts as /slash commands
      }
    }
  },
  display = {
    diff = {
      provider = "mini_diff",
    },
    chat = {
      render_headers = true,
    },
  },
  prompt_library = {

    --[[ ["Cursor Rules"] = {
      strategy = "chat",
      description = "Chat with cursor rules",
      opts = {
        -- ...
        short_name = "cursorRules"
      },
      prompts = {
        {
          role = "system",
          --[[ opts = {
            contains_code = true,
          }, ]\]
          content = function(context)
            local ctx = require("contextfiles.extensions.codecompanion")

            local ctx_opts = { }
            local format_opts = { }

            return ctx.get(context.filename, ctx_opts, format_opts)
          end,
        },
        {
          role = "user",
          opts = {
            contains_code = true,
          },
          content = ""
        }
      },
    } ]]
    ["Cursor Rules"] = {
      strategy = "chat",
      description = "Chat with context files",
      opts = {
        -- ...
      },
      prompts = {
        {
          role = "user",
          opts = {
            contains_code = true,
          },
          content = function(context)
            local ctx = require("codecompanion").extensions.contextfiles

            local ctx_opts = {
              -- ...
            }
            local format_opts = {
              -- ...
            }

            return ctx.get(context.filename, ctx_opts, format_opts)
          end,
        },
      },
    }
  },
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  },
  strategies = {
    chat = {
      slash_commands = {
        ["file"] = {
          -- Location to the slash command in CodeCompanion
          callback = "strategies.chat.slash_commands.file",
          description = "Select a file using Telescope",
          opts = {
            provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
            contains_code = true,
          },
        },
      },
    },
  },
}

if vim.fn.executable(openai_key_path) == 1 then
  setup["adapters"]= {
    opts = {
      show_defaults = false,
    },
    anthropic = adapter({
      name = "anthropic",
      url = "https://proxy-shopify-ai.local.shop.dev/v1/chat/completions",
      default_model = "anthropic:claude-sonnet-4",
      model_choices = { ["claude-sonnet-4"] = { opts = { can_reason = true } } },
    }),
    gemini = adapter({
      name = "gemini",
      url = "https://proxy-shopify-ai.local.shop.dev/v1/chat/completions",
      default_model = "google:gemini-2.5-pro",
    }),
    huggingface = adapter({
      name = "huggingface",
      url = "https://proxy-shopify-ai.local.shop.dev/v1/chat/completions",
      default_model = "huggingface:meta-llama/Meta-Llama-3.1-70B-Instruct",
    }),
    openai = adapter({
      name = "openai",
      url = "https://proxy-shopify-ai.local.shop.dev/vendors/openai/v1/chat/completions",
    }),
  }
  setup["strategies"].chat.adapter = "anthropic"
  setup["strategies"].inline = {
    adapter = "anthropic",
  }
end

return setup


-- local openai_key_path = vim.fn.expand("openai_key")
-- local openai_cmd = "cmd:" .. openai_key_path .. " cat"
--
-- local function get_recently_modified_files(days)
--   local seconds_in_day = 86400
--   local cutoff_time = os.time() - (days * seconds_in_day)
--   local files_list = {}
--
--   -- Function to check if a file was modified within the time period
--   local function check_file_mtime(file)
--     local attrs = vim.loop.fs_stat(file)
--     if attrs and attrs.mtime and attrs.mtime.sec >= cutoff_time then
--       return true
--     end
--     return false
--   end
--
--   -- Function to recursively scan directories
--   local function scan_dir(dir)
--     local handle = vim.loop.fs_scandir(dir)
--     if not handle then
--       return
--     end
--
--     while true do
--       local name, type = vim.loop.fs_scandir_next(handle)
--       if not name then
--         break
--       end
--
--       local path = dir .. "/" .. name
--
--       -- Skip hidden files and directories
--       if name:sub(1, 1) ~= "." then
--         if type == "directory" then
--           scan_dir(path)
--         elseif type == "file" then
--           if check_file_mtime(path) then
--             table.insert(files_list, path)
--           end
--         end
--       end
--     end
--   end
--
--   -- Start scanning from the current directory
--   local current_dir = vim.fn.getcwd()
--   scan_dir(current_dir)
--
--   return files_list
-- end
--
-- return {
--   cond = function()
--     return vim.fn.executable(openai_key_path)
--   end,
--   config = function()
--     local config = require("codecompanion.config")
--
--     local function adapter(options)
--       local base = require("codecompanion.adapters." .. options.name)
--       local openai = require("codecompanion.adapters.openai")
--       local default_model = options.default_model or base.schema.model.default
--
--       return require("codecompanion.adapters").extend(base, {
--         url = options.url,
--         env = {
--           api_key = openai_cmd,
--         },
--         handlers = openai.handlers,
--         headers = openai.headers,
--         parameters = {
--           model = "${model}",
--         },
--         schema = {
--           model = {
--             default = default_model,
--             choices = options.choices or { default_model },
--           },
--         },
--       })
--     end
--
--     return {
--       adapters = {
--         opts = {
--           show_defaults = false,
--         },
--         anthropic = adapter({
--           name = "anthropic",
--           url = "https://proxy.shopify.ai/v1/chat/completions",
--           default_model = "anthropic:claude-3-7-sonnet-20250219",
--           model_choices = { ["claude-3-7-sonnet-20250219"] = { opts = { can_reason = true } } },
--         }),
--         gemini = adapter({
--           name = "gemini",
--           url = "https://proxy.shopify.ai/v1/chat/completions",
--           default_model = "google:gemini-1.5-flash",
--         }),
--         huggingface = adapter({
--           name = "huggingface",
--           url = "https://proxy.shopify.ai/v1/chat/completions",
--           default_model = "huggingface:meta-llama/Meta-Llama-3.1-70B-Instruct",
--         }),
--         openai = adapter({
--           name = "openai",
--           url = "https://proxy.shopify.ai/vendors/openai/v1/chat/completions",
--         }),
--       },
--       strategies = {
--         chat = {
--           adapter = "anthropic",
--           slash_commands = {
--             ["unmerged_git_files"] = {
--               description = "List all files not in main branch with their content (untracked, staged, unstaged, and committed)",
--               ---@param chat CodeCompanion.Chat
--               callback = function(chat)
--                 local function run_command(cmd)
--                   local handle = io.popen(cmd)
--                   if handle then
--                     local result = handle:read("*a")
--                     handle:close()
--                     return result
--                   end
--                   return ""
--                 end
--
--                 local function get_file_content(filepath)
--                   local file = io.open(filepath, "r")
--                   if file then
--                     local content = file:read("*all")
--                     file:close()
--                     return content
--                   end
--                   return "Could not read file content"
--                 end
--
--                 local output = "# Files not in main branch:\n\n"
--                 local file_count = 0
--
--                 -- Get untracked files
--                 local untracked_files = {}
--                 for file in run_command("git ls-files --others --exclude-standard"):gmatch("[^\r\n]+") do
--                   table.insert(untracked_files, file)
--                 end
--
--                 if #untracked_files > 0 then
--                   output = output .. "## Untracked files:\n\n"
--                   for _, file in ipairs(untracked_files) do
--                     output = output .. "### " .. file .. "\n\n```\n" .. get_file_content(file) .. "\n```\n\n"
--                     file_count = file_count + 1
--                   end
--                 end
--
--                 -- Get staged files
--                 local staged_files = {}
--                 for file in run_command("git diff --name-only --cached"):gmatch("[^\r\n]+") do
--                   table.insert(staged_files, file)
--                 end
--
--                 if #staged_files > 0 then
--                   output = output .. "## Staged files:\n\n"
--                   for _, file in ipairs(staged_files) do
--                     output = output .. "### " .. file .. "\n\n```\n" .. get_file_content(file) .. "\n```\n\n"
--                     file_count = file_count + 1
--                   end
--                 end
--
--                 -- Get unstaged but tracked files
--                 local unstaged_files = {}
--                 for file in run_command("git diff --name-only"):gmatch("[^\r\n]+") do
--                   table.insert(unstaged_files, file)
--                 end
--
--                 if #unstaged_files > 0 then
--                   output = output .. "## Unstaged files:\n\n"
--                   for _, file in ipairs(unstaged_files) do
--                     output = output .. "### " .. file .. "\n\n```\n" .. get_file_content(file) .. "\n```\n\n"
--                     file_count = file_count + 1
--                   end
--                 end
--
--                 -- Get current branch
--                 local current_branch = run_command("git rev-parse --abbrev-ref HEAD"):gsub("%s+$", "")
--
--                 -- Get all files changed in commits that are in the current branch but not in main
--                 local committed_files = {}
--                 for file in run_command("git diff --name-only main..." .. current_branch):gmatch("[^\r\n]+") do
--                   -- Check if file exists (it might have been deleted in a commit)
--                   local exists = run_command("test -f " .. file .. " && echo 'yes' || echo 'no'"):gsub("%s+$", "")
--                   if exists == "yes" then
--                     table.insert(committed_files, file)
--                   end
--                 end
--
--                 if #committed_files > 0 then
--                   output = output .. "## Committed files not in main:\n\n"
--                   for _, file in ipairs(committed_files) do
--                     output = output .. "### " .. file .. "\n\n```\n" .. get_file_content(file) .. "\n```\n\n"
--                     file_count = file_count + 1
--                   end
--                 end
--
--                 if file_count == 0 then
--                   return vim.notify("No unmerged files found", vim.log.levels.INFO, { title = "CodeCompanion" })
--                 else
--                   chat:add_reference({ role = "user", content = output }, "git", "<unmerged_git_files>")
--                 end
--               end,
--               opts = {
--                 contains_code = true,
--               },
--             },
--             ["changed_files"] = {
--               description = "List all files changed in the last N days in journals and pages folders",
--               ---@param chat CodeCompanion.Chat
--               callback = function(chat)
--                 -- Get current date information
--                 local current_date = os.date("*t")
--                 local current_day = current_date.wday -- 1 is Sunday, 2 is Monday, etc.
--
--                 -- Calculate previous weekday
--                 local previous_weekday_days_ago = 1
--                 if current_day == 1 then -- Sunday
--                   previous_weekday_days_ago = 2
--                 elseif current_day == 2 then -- Monday
--                   previous_weekday_days_ago = 3
--                 end
--
--                 -- Get the day name for the previous weekday
--                 local days_of_week = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
--                 local previous_date = os.time({
--                   year = current_date.year,
--                   month = current_date.month,
--                   day = current_date.day - previous_weekday_days_ago,
--                   hour = 0,
--                   min = 0,
--                   sec = 0,
--                 })
--                 local previous_date_table = os.date("*t", previous_date)
--                 local previous_weekday_name = days_of_week[previous_date_table.wday]
--
--                 local days = nil
--                 local cutoff_time = nil
--                 local cutoff_date = nil
--
--                 while true do
--                   local days_input = vim.fn.input(
--                     "When was the last standup? (days ago, day of week, or date YYYY-MM-DD) ["
--                       .. previous_weekday_name
--                       .. "]: "
--                   )
--
--                   -- If no input was provided, use the default date
--                   if days_input == "" then
--                     days_input = previous_weekday_days_ago
--                   end
--
--                   -- Case 1: Number of days ago
--                   days = tonumber(days_input)
--                   if days and days > 0 then
--                     cutoff_time = os.time() - (days * 86400)
--                     cutoff_date = os.date("%Y-%m-%d", cutoff_time)
--                     break
--                   end
--
--                   -- Case 2: Day of the week
--                   local day_of_week = days_input:lower()
--                   local days_map = {
--                     ["monday"] = 0,
--                     ["mon"] = 0,
--                     ["m"] = 0,
--                     ["tuesday"] = 0,
--                     ["tue"] = 0,
--                     ["tu"] = 0,
--                     ["wednesday"] = 0,
--                     ["wed"] = 0,
--                     ["w"] = 0,
--                     ["thursday"] = 0,
--                     ["thurs"] = 0,
--                     ["thu"] = 0,
--                     ["th"] = 0,
--                     ["friday"] = 0,
--                     ["fri"] = 0,
--                     ["f"] = 0,
--                     ["saturday"] = 0,
--                     ["sat"] = 0,
--                     ["sa"] = 0,
--                     ["sunday"] = 0,
--                     ["sun"] = 0,
--                     ["su"] = 0,
--                   }
--
--                   -- Calculate days since the specified day of week
--                   if days_map[day_of_week] ~= nil then
--                     local current_day = tonumber(os.date("%w")) -- 0 is Sunday, 6 is Saturday
--                     local target_day = nil
--
--                     -- Map day names to numbers (0-6)
--                     if day_of_week:match("^m") then
--                       target_day = 1 -- Monday
--                     elseif day_of_week:match("^tu") then
--                       target_day = 2 -- Tuesday
--                     elseif day_of_week:match("^w") then
--                       target_day = 3 -- Wednesday
--                     elseif day_of_week:match("^th") then
--                       target_day = 4 -- Thursday
--                     elseif day_of_week:match("^f") then
--                       target_day = 5 -- Friday
--                     elseif day_of_week:match("^sa") then
--                       target_day = 6 -- Saturday
--                     elseif day_of_week:match("^su") then
--                       target_day = 0 -- Sunday
--                     end
--
--                     -- Calculate days since the target day
--                     local days_since = (current_day - target_day) % 7
--                     if days_since == 0 then
--                       days_since = 7
--                     end -- If today, use a week ago
--
--                     cutoff_time = os.time() - (days_since * 86400)
--                     cutoff_date = os.date("%Y-%m-%d", cutoff_time)
--                     days = days_since
--                     break
--                   end
--
--                   -- Case 3: Date in YYYY-MM-DD format
--                   local year, month, day = days_input:match("(%d%d%d%d)-(%d%d)-(%d%d)")
--                   if year and month and day then
--                     cutoff_time = os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })
--                     cutoff_date = days_input
--
--                     -- Calculate days between the specified date and today
--                     local days_diff = math.floor((os.time() - cutoff_time) / 86400)
--                     days = days_diff
--                     break
--                   end
--
--                   -- If we get here, the input wasn't valid
--                   vim.notify(
--                     "Please enter a valid input: number of days, day of week, or date (YYYY-MM-DD)",
--                     vim.log.levels.WARN
--                   )
--                 end
--
--                 -- Get recently modified files
--                 local all_files = get_recently_modified_files(days)
--                 local files_list = {}
--                 local journal_files = {}
--                 local page_files = {}
--
--                 -- Function to extract date from journal filename (assuming format like YYYY_MM_DD.md)
--                 local function extract_date_from_filename(filename)
--                   local year, month, day = filename:match("(%d%d%d%d)_(%d%d)_(%d%d)")
--                   if year and month and day then
--                     return year .. "-" .. month .. "-" .. day
--                   end
--                   return nil
--                 end
--
--                 -- Filter for journals and pages folders, but include all modified files
--                 for _, file in ipairs(all_files) do
--                   -- Skip templates.md file
--                   if file:match("/pages/templates%.md$") then
--                   -- Skip this file
--                   elseif file:match("/journals/") then
--                     table.insert(journal_files, file)
--                     table.insert(files_list, file)
--                   elseif file:match("/pages/") then
--                     table.insert(page_files, file)
--                     table.insert(files_list, file)
--                   end
--                 end
--
--                 -- Create a message first to ensure the chat is initialized
--                 local message = "# Standup Update Request\n\n"
--                   .. "Current date and time: "
--                   .. vim.fn.strftime("%c")
--                   .. "\n"
--                   .. "Last standup: "
--                   .. days
--                   .. " days ago (on "
--                   .. cutoff_date
--                   .. ")\n\n"
--                   .. "**CRITICAL INSTRUCTION:** Only include information from on or after "
--                   .. cutoff_date
--                   .. " in your standup update.\n"
--                   .. "**DO NOT** include any work or tasks from before this date, even if the files were recently modified.\n\n"
--                   .. "I've provided "
--                   .. #files_list
--                   .. " Logseq files that were modified recently, but you must filter the content based on dates."
--
--                 -- Add references for changed files after a short delay
--                 vim.defer_fn(function()
--                   if #files_list > 0 then
--                     -- Create a summary of changed files
--                     local files_summary = "# Logseq files changed in the last "
--                       .. days
--                       .. " days (since "
--                       .. cutoff_date
--                       .. "):\n\n"
--                     files_summary = files_summary .. "## Journal Files:\n\n"
--
--                     for _, file in ipairs(journal_files) do
--                       local filename = file:match("([^/]+)$")
--                       local file_date = extract_date_from_filename(filename) or "Unknown date"
--
--                       -- Note whether the journal file is from before or after the cutoff
--                       local date_note = ""
--                       if file_date then
--                         if file_date >= cutoff_date then
--                           date_note = " (after standup)"
--                         else
--                           date_note = " (before standup - check for relevant date references inside)"
--                         end
--                       end
--
--                       files_summary = files_summary .. "- " .. filename .. " (" .. file_date .. ")" .. date_note .. "\n"
--
--                       -- Try to get file content and add as reference
--                       local f = io.open(file, "r")
--                       if f then
--                         local content = f:read("*all")
--                         f:close()
--
--                         if content and content ~= "" then
--                           chat:add_reference({
--                             role = "user",
--                             content = "# Journal: " .. file_date .. "\n\n" .. content,
--                           }, "journal", filename)
--                         end
--                       end
--                     end
--
--                     files_summary = files_summary .. "\n## Page Files:\n\n"
--                     for _, file in ipairs(page_files) do
--                       local filename = file:match("([^/]+)$")
--                       files_summary = files_summary
--                         .. "- "
--                         .. filename
--                         .. " (check for relevant date references inside)\n"
--
--                       -- Try to get file content and add as reference
--                       local f = io.open(file, "r")
--                       if f then
--                         local content = f:read("*all")
--                         f:close()
--
--                         if content and content ~= "" then
--                           chat:add_reference({
--                             role = "user",
--                             content = "# Page: " .. filename .. "\n\n" .. content,
--                           }, "page", filename)
--                         end
--                       end
--                     end
--
--                     chat:add_reference({
--                       role = "user",
--                       content = files_summary,
--                     }, "summary", "changed_files_summary")
--
--                     -- Add explicit filtering instructions
--                     chat:add_reference({
--                       role = "user",
--                       content = "# IMPORTANT FILTERING INSTRUCTIONS\n\n"
--                         .. "Today's date: "
--                         .. os.date("%Y-%m-%d")
--                         .. "\n"
--                         .. "Last standup date: "
--                         .. cutoff_date
--                         .. "\n\n"
--                         .. "1. ONLY include work done ON or AFTER "
--                         .. cutoff_date
--                         .. "\n"
--                         .. "2. ONLY include tasks planned for today ("
--                         .. os.date("%Y-%m-%d")
--                         .. ") or future dates\n"
--                         .. "3. For files dated before "
--                         .. cutoff_date
--                         .. ", scan for content that explicitly references dates on or after "
--                         .. cutoff_date
--                         .. "\n"
--                         .. "4. If you're unsure about when something was done, DO NOT include it\n"
--                         .. "5. Include summaries of any investigations or research documented in files with dates in the timeframe\n"
--                         .. "6. Content in older journal files may have been added recently with newer date tags - include this content if it has dates on or after the last standup\n"
--                         .. "7. DO NOT include items marked as LATER - these are not relevant for the standup\n"
--                         .. "It is better to provide an incomplete standup than to include outdated information.",
--                     }, "instructions", "filtering_requirements")
--
--                     -- Notify user that references were added
--                     vim.notify("Added " .. #files_list .. " Logseq file references to the chat", vim.log.levels.INFO)
--                   else
--                     vim.notify("No recently modified Logseq files found", vim.log.levels.INFO)
--                   end
--                 end, 500) -- 500ms delay to ensure chat is initialized
--
--                 return message
--               end,
--               opts = {
--                 contains_code = true,
--               },
--             },
--           },
--         },
--         inline = {
--           adapter = "anthropic",
--         },
--       },
--       prompt_library = {
--         ["PR Description"] = {
--           strategy = "workflow",
--           description = "Use a workflow to guide an LLM in writing code",
--           opts = {
--             is_default = true,
--             short_name = "prd",
--           },
--           prompts = {
--             {
--               -- We can group prompts together to make a workflow
--               -- This is the first prompt in the workflow
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- You are an expert at writing clear, concise pull request descriptions that highlight the key changes, their purpose, and any important implementation details. Errors are monitored using Bugsnag. Logs and metrics are collected in Observe, which is built on Grafana. The output should be wrapped in FOUR backticks, not three.
--
-- This is the format you use to write PR descriptions. Each time you modify the PR description, maintain this structure.
--
-- ````
-- ### 💡 What it is
--
--
-- ### ❓ Why
--
--
-- ### 🔧 How
--
--
-- ### 🧪 Testing
--
--
-- ### 🔄 Alternatives Considered
--
--
-- ### 🔮 Future Work
--
--
-- ### 💬 Concerns / Questions
--
--
-- ### 🎩 Tophat instructions
--
--
-- ### ✈️ Post-deploy instructions
--
-- ````
--
-- ]],
--                 opts = {
--                   visible = false,
--                 },
--               },
--               {
--                 role = config.constants.USER_ROLE,
--                 content = function()
--                   local function run_command(cmd)
--                     local handle = io.popen(cmd)
--                     if handle then
--                       local result = handle:read("*a")
--                       handle:close()
--                       return result
--                     end
--                     return ""
--                   end
--
--                   -- Get current branch name
--                   local current_branch = run_command("git rev-parse --abbrev-ref HEAD"):gsub("%s+$", "")
--
--                   -- Check if this branch is part of a chain
--                   local parent_branch = "main" -- Default to main
--                   local git_config_cmd = "git config --get branch." .. current_branch .. ".parentBranch"
--                   local parent_from_config = run_command(git_config_cmd):gsub("%s+$", "")
--
--                   if parent_from_config ~= "" then
--                     -- Use the parent branch from config
--                     parent_branch = parent_from_config
--                   end
--
--                   local commit_list = run_command(
--                     "git log --pretty=format:'Commit: %h%nAuthor: %an%nDate: %ad%n%n%B%n-------------------%n' "
--                       .. parent_branch
--                       .. ".."
--                       .. current_branch
--                   )
--
--                   -- Get a more detailed but summarized diff (limiting output size)
--                   local diff_summary = run_command("git diff --unified=1 " .. parent_branch .. ".." .. current_branch)
--
--                   -- Get list of files changed with their status
--                   local files_changed =
--                     run_command("git diff --name-status " .. parent_branch .. ".." .. current_branch)
--
--                   return string.format(
--                     [[
-- <PullRequestInfo>
--   <CurrentBranch>%s</CurrentBranch>
--   <ParentBranch>%s</ParentBranch>
--   <Commits>
-- %s
--   </Commits>
--   <FilesChanged>%s</FilesChanged>
--   <DiffSummary>
-- %s
--   </DiffSummary>
-- </PullRequestInfo>
--
-- Based on the information above, write a pull request description.
--
-- Fill in each section with relevant information based on the commits and changes:
--
-- - "What it is": A concise summary of the changes made
-- - "Why": The rationale and business context for these changes
-- - "How": Technical implementation details and approach
-- - "Testing": What tests were added/modified and what edge cases they cover
-- - "Alternatives Considered": DO NOT FILL THIS IN, LEAVE AS A PLACEHOLDER
-- - "Future Work": Any planned follow-up work or known limitations
-- - "Concerns / Questions": Any areas of uncertainty or questions for reviewers
-- - "Tophat instructions": Steps to manually test the changes
-- - "Post-deploy instructions": Actions needed after deployment
--
-- If there's no relevant information for a section, leave it with a brief note like "N/A" or "None at this time".
--
-- Be concise but thorough. Focus on explaining the purpose, rationale, and implementation details of the changes. Analyze the diff to understand what functionality was added, modified, or removed.
--
-- Pay special attention to the commit messages to understand the progression and intent of the changes.
-- ]],
--                     current_branch,
--                     parent_branch,
--                     commit_list ~= "" and commit_list or "No commits found",
--                     files_changed ~= "" and files_changed or "No files changed",
--                     diff_summary ~= "" and diff_summary or "No changes detected"
--                   )
--                 end,
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Are there any code snippets that should be added? Perhaps examples of how to use new methods or snippets of changed code that is notable? Don't overload the description with code snippets, be very picky. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Have all observability concerns been considered? It is extremely important to know if errors have occurred in our systems. Where might something fail after deployment? Update the PR description with any monitoring or observability considerations. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "What testing was done for these changes? Are there any edge cases that should be highlighted for reviewers to check? Please update the Testing section with this information. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Is there any future work that should follow this PR? Are there known limitations or technical debt being introduced? Please update the Future Work section with this information. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Does this change introduce any new dependencies or have any architectural implications? Please update the How section to include this information if relevant. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Great! Now please review and refine the PR description. Make sure it follows the exact format I specified, with all section headers preserved. Ensure the content is concise, technical, and focused on the actual changes made in the commits. The description should be valuable both for immediate reviewers and for future developers trying to understand why this change was made. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Simplify every section. The PR description should be a quick read that only includes the most important details. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--           },
--         },
--         ["Medium PR Description"] = {
--           strategy = "workflow",
--           description = "Generate a moderately detailed PR description",
--           opts = {
--             is_default = false,
--             short_name = "mprd",
--           },
--           prompts = {
--             {
--               -- First prompt in the workflow
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- You are an expert at writing clear, concise pull request descriptions. The output should be wrapped in FOUR backticks, not three.
--
-- This is the format you use to write medium-sized PR descriptions:
--
-- ````
-- ### 💡 What it is
-- [A clear description of the change]
--
-- ### ❓ Why
-- [The business or technical rationale for the change]
--
-- ### 🔧 How
-- [Technical implementation details and approach]
--
-- ### 🧪 Testing
-- [How these changes were tested]
--
-- ### 🔄 Alternatives Considered
--
--
-- ### 💬 Concerns / Questions
--
--
-- ### 🎩 Tophat instructions
-- [Steps to manually test the changes, if applicable]
-- ````
--
-- Your descriptions should be professional and thorough without being overly verbose. Focus on clarity and providing enough context for reviewers to understand the changes.
-- ]],
--                 opts = {
--                   visible = false,
--                 },
--               },
--               {
--                 role = config.constants.USER_ROLE,
--                 content = function()
--                   local function run_command(cmd)
--                     local handle = io.popen(cmd)
--                     if handle then
--                       local result = handle:read("*a")
--                       handle:close()
--                       return result
--                     end
--                     return ""
--                   end
--
--                   -- Get current branch name
--                   local current_branch = run_command("git rev-parse --abbrev-ref HEAD"):gsub("%s+$", "")
--
--                   -- Check if this branch is part of a chain
--                   local parent_branch = "main" -- Default to main
--                   local git_config_cmd = "git config --get branch." .. current_branch .. ".parentBranch"
--                   local parent_from_config = run_command(git_config_cmd):gsub("%s+$", "")
--
--                   if parent_from_config ~= "" then
--                     -- Use the parent branch from config
--                     parent_branch = parent_from_config
--                   end
--
--                   local commit_list = run_command(
--                     "git log --pretty=format:'Commit: %h%nAuthor: %an%nDate: %ad%n%n%B%n-------------------%n' "
--                       .. parent_branch
--                       .. ".."
--                       .. current_branch
--                   )
--
--                   -- Get a more detailed but summarized diff (limiting output size)
--                   local diff_summary = run_command("git diff --unified=1 " .. parent_branch .. ".." .. current_branch)
--
--                   -- Get list of files changed with their status
--                   local files_changed =
--                     run_command("git diff --name-status " .. parent_branch .. ".." .. current_branch)
--
--                   return string.format(
--                     [[
-- <PullRequestInfo>
--   <CurrentBranch>%s</CurrentBranch>
--   <ParentBranch>%s</ParentBranch>
--   <Commits>
-- %s
--   </Commits>
--   <FilesChanged>%s</FilesChanged>
--   <DiffSummary>
-- %s
--   </DiffSummary>
-- </PullRequestInfo>
--
-- Based on the information above, write a medium-sized pull request description.
--
-- Fill in each section with relevant information based on the commits and changes:
--
-- - "What it is": A clear description of the changes made (2-3 sentences)
-- - "Why": The rationale and business context for these changes (2-3 sentences)
-- - "How": Technical implementation details and approach (3-5 sentences)
-- - "Testing": What tests were added/modified or how the changes were tested (2-3 sentences)
-- - "Alternatives Considered": Leave this section empty
-- - "Concerns / Questions": Leave this section empty
-- - "Tophat instructions": Steps to manually test the changes, if applicable (2-3 sentences)
--
-- Be thorough but concise. Focus on explaining the purpose, rationale, and implementation details of the changes. Analyze the diff to understand what functionality was added, modified, or removed.
-- ]],
--                     current_branch,
--                     parent_branch,
--                     commit_list ~= "" and commit_list or "No commits found",
--                     files_changed ~= "" and files_changed or "No files changed",
--                     diff_summary ~= "" and diff_summary or "No changes detected"
--                   )
--                 end,
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Are there any important technical details missing from the description? For example, are there any dependencies, performance considerations, or potential side effects that should be mentioned? If so, add them concisely to the appropriate section. Make sure you continue to use the required format and leave the Alternatives Considered and Concerns/Questions sections empty.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Review the PR description and ensure it's both thorough and professional. Make sure it follows the exact format I specified, with all section headers preserved. Each section should contain complete sentences that provide clear information about the changes. The description should be valuable for reviewers while still being concise enough to read quickly. Make sure the Alternatives Considered and Concerns/Questions sections remain empty.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Simplify every section. The PR description should be a quick read that only includes the most important details. Make sure you continue to use the required format.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--           },
--         },
--         ["Simple PR Description"] = {
--           strategy = "workflow",
--           description = "Generate a concise PR description for small changes",
--           opts = {
--             is_default = false,
--             short_name = "sprd",
--           },
--           prompts = {
--             {
--               -- First prompt in the workflow
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- You are an expert at writing clear, concise pull request descriptions for small changes. The output should be wrapped in FOUR backticks, not three.
--
-- This is the format you use to write simple PR descriptions:
--
-- ````
-- ### 💡 What it is
-- [A brief, specific description of the change]
--
-- ### ❓ Why
-- [The business or technical rationale for the change]
--
-- ### 🔧 How
-- [A concise technical implementation summary]
--
-- ### 🧪 Testing
-- [How these changes were tested or can be tested]
-- ````
--
-- Your descriptions should be professional and use complete sentences. Focus on clarity and precision rather than brevity at the expense of understanding.
-- ]],
--                 opts = {
--                   visible = false,
--                 },
--               },
--               {
--                 role = config.constants.USER_ROLE,
--                 content = function()
--                   local function run_command(cmd)
--                     local handle = io.popen(cmd)
--                     if handle then
--                       local result = handle:read("*a")
--                       handle:close()
--                       return result
--                     end
--                     return ""
--                   end
--
--                   -- Get current branch name
--                   local current_branch = run_command("git rev-parse --abbrev-ref HEAD"):gsub("%s+$", "")
--
--                   -- Check if this branch is part of a chain
--                   local parent_branch = "main" -- Default to main
--                   local git_config_cmd = "git config --get branch." .. current_branch .. ".parentBranch"
--                   local parent_from_config = run_command(git_config_cmd):gsub("%s+$", "")
--
--                   if parent_from_config ~= "" then
--                     -- Use the parent branch from config
--                     parent_branch = parent_from_config
--                   end
--
--                   local commit_list = run_command(
--                     "git log --pretty=format:'Commit: %h%nAuthor: %an%nDate: %ad%n%n%B%n-------------------%n' "
--                       .. parent_branch
--                       .. ".."
--                       .. current_branch
--                   )
--
--                   -- Get a more detailed but summarized diff (limiting output size)
--                   local diff_summary = run_command("git diff --unified=1 " .. parent_branch .. ".." .. current_branch)
--
--                   -- Get list of files changed with their status
--                   local files_changed =
--                     run_command("git diff --name-status " .. parent_branch .. ".." .. current_branch)
--
--                   return string.format(
--                     [[
-- <PullRequestInfo>
--   <CurrentBranch>%s</CurrentBranch>
--   <ParentBranch>%s</ParentBranch>
--   <Commits>
-- %s
--   </Commits>
--   <FilesChanged>%s</FilesChanged>
--   <DiffSummary>
-- %s
--   </DiffSummary>
-- </PullRequestInfo>
--
-- Based on the information above, write a simple, concise pull request description.
--
-- Fill in each section with relevant information based on the commits and changes:
--
-- - "What it is": A clear summary of the changes made (1-2 complete sentences)
-- - "Why": The rationale for these changes (1-2 complete sentences)
-- - "How": A concise technical implementation summary (1-2 complete sentences)
-- - "Testing": How these changes were tested or can be tested (1-2 complete sentences)
--
-- Be concise but professional. Use complete sentences and ensure each section provides meaningful information. Focus on clarity and precision rather than brevity at the expense of understanding.
-- ]],
--                     current_branch,
--                     parent_branch,
--                     commit_list ~= "" and commit_list or "No commits found",
--                     files_changed ~= "" and files_changed or "No files changed",
--                     diff_summary ~= "" and diff_summary or "No changes detected"
--                   )
--                 end,
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Review the PR description and ensure it's both concise and professional. Make sure it follows the exact format I specified, with all section headers preserved. Each section should contain complete sentences that provide clear, specific information about the changes. The entire description should be readable in under 30 seconds while still conveying all essential information.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Check if there are any important technical details missing from the description. For example, are there any potential side effects, dependencies, or performance considerations that should be mentioned? If so, add them concisely to the appropriate section while maintaining the overall brevity of the description. Show me the final output, even if there are no changes.",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--           },
--         },
--         ["Standup"] = {
--           strategy = "chat",
--           description = "Generate a standup update based on Logseq notes and recent file changes",
--           opts = {
--             is_default = false,
--             short_name = "su",
--           },
--           prompts = {
--             {
--               role = config.constants.SYSTEM_ROLE,
--               content = [[
-- You are a personal assistant creating a standup update. Your ONLY goal is to extract information about work done since the last standup.
--
-- ## STRICT FILTERING RULES - READ CAREFULLY:
--
-- 1. ONLY include information from the timeframe between the last standup and now (including the day of the last standup).
-- 2. For journal files:
--    - If the journal file's date is EQUAL TO or AFTER the last standup date, you can include all content.
--    - If the journal file's date is BEFORE the last standup date, ONLY include content that is explicitly tagged with dates EQUAL TO or AFTER the last standup.
-- 3. For page files: ONLY include content that explicitly references dates EQUAL TO or AFTER the last standup.
-- 4. IGNORE all content that doesn't have a clear timestamp or date reference within the relevant timeframe.
-- 5. If a file was modified but contains no relevant dated content, EXCLUDE it completely.
-- 6. DO NOT include items marked as LATER - these are not relevant for the standup.
-- 7. DO NOT include tasks about writing project updates - these are not noteworthy for standups.
--
-- ## Content Analysis:
-- - Journal files are named with dates (e.g., 2023_05_15.md)
-- - Look for explicit date references in content (May 15, 2023, 2023-05-15, etc.)
-- - Tasks marked as DONE or DOING are only relevant if completed/worked on on or after the last standup
-- - TODO items are only relevant if they're planned for today or future dates
-- - LATER items should be completely excluded regardless of their date
-- - Tasks about writing project updates should be completely excluded
-- - Generic notes or investigations in files with dates in the timeframe should be summarized in the "What I've done" section
-- - Content in older journal files may have been added recently with newer date tags - include this content if it has dates on or after the last standup
--
-- ## Task Hierarchy:
-- - Maintain proper task hierarchy in your output
-- - If an item is a detail or subtask of a main task, represent it as a nested list item
-- - Do not put the main task and its details/subtasks at the same level of indentation
-- - Example of correct hierarchy:
--   * Main Task A
--     * Subtask A.1
--     * Subtask A.2
--   * Main Task B
-- - Example of incorrect hierarchy (avoid this):
--   * Main Task A
--   * Subtask A.1
--   * Subtask A.2
--   * Main Task B
--
-- ## Standup Format:
-- Organize the standup update by project groups (#gsd-* tags), with each group containing the following sections:
--
-- For each #gsd-* tag (e.g., #gsd-project-name):
--
-- ### [Project Name] (#gsd-tag)
--
-- 1. **What I've done:**
--    - ONLY include completed work (DONE and CANCELLED items) with dates on or after the last standup
--    - ONLY include in-progress work (DOING items) that was worked on on or after the last standup
--    - Include summaries of any investigations or research documented in files with dates in the timeframe
--    - Include content from older journal files IF it has explicit date references on or after the last standup
--    - DO NOT include any LATER items
--    - DO NOT include tasks about writing project updates
--    - Maintain proper task hierarchy with subtasks nested under their parent tasks
--
-- 2. **Blockers/challenges:**
--    - ONLY include current blockers mentioned in the relevant timeframe
--    - Maintain proper task hierarchy with subtasks nested under their parent tasks
--
-- 3. **What I'll do today:**
--    - PRIORITIZE in-progress items (DOING) first, followed by not-yet-started items (TODO)
--    - ONLY include TODO items from today's journal or explicitly planned for today
--    - DO NOT include LATER items
--    - DO NOT include tasks about writing project updates
--    - Maintain proper task hierarchy with subtasks nested under their parent tasks
--
-- After all #gsd-* tagged items, create an "Uncategorized" section for items without specific project tags, following the same format:
--
-- ### Uncategorized
--
-- 1. **What I've done:**
--    - (Same rules as above)
--
-- 2. **Blockers/challenges:**
--    - (Same rules as above)
--
-- 3. **What I'll do today:**
--    - (Same rules as above)
--
-- IMPORTANT: If you cannot find any relevant information for a section, state "No information available" rather than including out-of-date content. If a project has no relevant information at all, omit that project entirely.
--
-- Remember: It is better to provide less information than to include outdated information from before the last standup.
--
-- You never include updates that are from before the most recent standup. Standup happens first thing in the morning, so any work done on April 22, 2025 would be presented in April 23, 2025's standup. Use dates in file names as hints for when work was done. If a file's name doesn't fall in the timeframe, don't include any content from it that doesn't reference a date that _does_ fall in the timeframe.
--
-- Logseq files are organized in two main folders:
-- 1. /journals/ - Contains daily notes with timestamps
-- 2. /pages/ - Contains topic-specific notes and projects
--
-- You will be provided with the content of Logseq files that have changed since the last standup. Use this information to help identify what work has been done.
--
-- Focus on extracting:
-- - Completed tasks (DONE)
-- - In-progress tasks (DOING)
-- - Planned tasks (TODO)
-- - Any notes with specific dates that fall within the timeframe (on or after the last standup)
-- - Generic notes or investigation summaries from files with dates in the timeframe
-- - NEVER include tasks marked as LATER
-- - NEVER include tasks about writing project updates
--
-- Format your response as a concise standup update organized by project groups (#gsd-* tags), with each group containing sections for what was done, current blockers, and what's planned for today. Always maintain proper task hierarchy with subtasks properly nested under their parent tasks.
-- ]],
--               opts = {
--                 visible = true,
--               },
--             },
--             {
--               role = config.constants.USER_ROLE,
--               content = "/changed_files",
--             },
--           },
--         },
--         ["GitHub Issue"] = {
--           strategy = "workflow",
--           description = "Create a well-structured GitHub issue with background and acceptance criteria",
--           opts = {
--             is_default = false,
--             short_name = "issue",
--           },
--           prompts = {
--             {
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- You are an expert at creating clear, well-structured GitHub issues. Your goal is to help the user create an issue that will be valuable whether it's addressed immediately or sits in a backlog for a year.
--
-- The issue must follow this exact format, wrapped in FOUR backticks:
--
-- ````
-- ## Background
--
-- [Background information explaining the context, problem, and why this issue needs to be addressed]
--
-- ## Acceptance Criteria
--
-- - [ ] [Criterion 1]
--   - [Detail or option]
--   - [Detail or option]
-- - [ ] [Criterion 2]
-- ````
--
-- You MUST gather all necessary information to create a valuable issue. If the user's initial description is incomplete, ask follow-up questions until you have:
-- 1. Clear understanding of the problem/feature
-- 2. Context about why it's needed
-- 3. Specific acceptance criteria that would make the solution successful
-- 4. Any constraints or requirements
--
-- Only proceed with writing the issue when you have sufficient information. Be persistent but helpful in your questions.
-- ]],
--                 opts = {
--                   visible = false,
--                 },
--               },
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "I need to create a GitHub issue. Can you help me structure it properly?",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- Now I'll help you gather the necessary information for a valuable GitHub issue.
--
-- Please provide:
-- 1. What is the issue or feature request about?
-- 2. What problem does it solve or what value does it add?
-- 3. What specific criteria would make the solution successful?
-- 4. Are there any constraints or requirements to consider?
--
-- The more details you can provide, the more valuable the issue will be for whoever works on it.
-- ]],
--                 opts = {
--                   visible = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- Based on what you've shared so far, I need more specific information to create a valuable GitHub issue.
--
-- Could you please clarify:
-- 1. What are the specific acceptance criteria that would make this solution successful?
-- 2. Are there any technical constraints or requirements that should be considered?
-- 3. Is there any additional context about why this is needed or important?
--
-- These details will help ensure the issue is clear and actionable, even if it sits in the backlog for a while.
-- ]],
--                 opts = {
--                   visible = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.SYSTEM_ROLE,
--                 content = [[
-- Thank you for providing those details. I'll now create a GitHub issue based on the information you've shared.
--
-- I'll structure it with a clear background section explaining the context and problem, followed by specific acceptance criteria with checkboxes that can be used to verify the issue is resolved correctly.
--
-- If you notice anything missing or that should be adjusted in the final issue, please let me know.
-- ]],
--                 opts = {
--                   visible = true,
--                 },
--               },
--             },
--             {
--               {
--                 role = config.constants.USER_ROLE,
--                 content = "Does the GitHub issue look complete and valuable? Is there anything else that should be added to make it more clear or actionable?",
--                 opts = {
--                   auto_submit = true,
--                 },
--               },
--             },
--           },
--         },
--       },
--     }
--   end,
-- }
--
