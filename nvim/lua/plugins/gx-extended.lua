return {
  {
    'rmagatti/gx-extended.nvim',
    config = function()
      require("gx-extended").setup {
        extensions = {
          { -- match github repos in lazy.nvim plugin specs
            patterns = { '*/plugins/**/*.lua' },
            name = "neovim plugins",
            match_to_url = function(line_string)
              local line = string.match(line_string, '["|\'].*/.*["|\']')
              local repo = vim.split(line, ':')[1]:gsub('["|\']', '')
              local url = 'https://github.com/' .. repo
              return line and repo and url or nil
            end,
          },
          { -- match github repos in lazy.nvim plugin specs
            patterns = { '*.md' },
            name = "github links",
            match_to_url = function(line_string)
              local repo = string.match(line_string, '([a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*)')
              local issue_number = string.match(line_string, '[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*#([0-9]*)')
              local url = 'https://github.com/' .. repo .. '/issues/' .. issue_number
              return repo and issue_number and url or nil
            end,
          },
          { -- match hackerone reports in markdown files
            patterns = { '*.*' },
            name = "HackerOne report",
            match_to_url = function(line_string)
              local line = string.match(line_string, 'h1[-]([0-9]*)')
              local report_id = vim.split(line, ':')[1]:gsub('["|\']', '')
              local url = 'https://hackerone.com/reports/' .. report_id
              return line and report_id and url or nil
            end,
          },
          { -- match hackerone reports in markdown files and opens them in the bug bounty app
            patterns = { '*.*' },
            name = "BugBounty app report",
            match_to_url = function(line_string)
              local line = string.match(line_string, 'bb[-]([0-9]*)')
              local report_id = vim.split(line, ':')[1]:gsub('["|\']', '')
              local url = 'https://bugbounty.shopify.io/reports/' .. report_id
              return line and report_id and url or nil
            end,
          },
          { -- match GSD project ID
            patterns = { '*.md' },
            name = "Vault GSD project",
            match_to_url = function(line_string)
              local line = string.match(line_string, '#gsd[:]([0-9]*)')
              local gsd_project_id = vim.split(line, ':')[1]:gsub('["|\']', '')
              local url = 'https://vault.shopify.io/gsd/projects/' .. gsd_project_id
              return line and gsd_project_id and url or nil
            end,
          },
        },

      }
    end
  }
}
