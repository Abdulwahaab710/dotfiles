-- 
return {
  {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {},
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('render-markdown').setup({
            file_types = { 'markdown', 'vimwiki' },
            checkbox = {
                -- Turn on / off checkbox state rendering
                enabled = true,
                -- Determines how icons fill the available space:
                --  inline:  underlying text is concealed resulting in a left aligned icon
                --  overlay: result is left padded with spaces to hide any additional text
                position = 'inline',
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'
                    icon = '󰄱 ',
                    -- Highlight for the unchecked icon
                    highlight = 'RenderMarkdownUnchecked',
                    -- Highlight for item associated with unchecked checkbox
                    scope_highlight = nil,
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'
                    icon = '󰱒 ',
                    -- Highlight for the checked icon
                    highlight = 'RenderMarkdownChecked',
                    -- Highlight for item associated with checked checkbox
                    scope_highlight = nil,
                },
                -- Define custom checkbox states, more involved as they are not part of the markdown grammar
                -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
                -- Can specify as many additional states as you like following the 'todo' pattern below
                --   The key in this case 'todo' is for healthcheck and to allow users to change its values
                --   'raw':             Matched against the raw text of a 'shortcut_link'
                --   'rendered':        Replaces the 'raw' value when rendering
                --   'highlight':       Highlight for the 'rendered' icon
                --   'scope_highlight': Highlight for item associated with custom checkbox
                custom = {
                    started = { raw = '[S]', rendered = '󰦕 ', highlight = 'RenderMarkdownWarn', scope_highlight = nil },
                    deleted = { raw = '[D]', rendered = ' ', highlight = 'RenderMarkdownError', scope_highlight = nil },
                },
            },
        })
        vim.treesitter.language.register('markdown', 'vimwiki')

        require('obsidian').get_client().opts.ui.enable = false
        local namespaceID = vim.api.nvim_get_namespaces()["ObsidianUI"]
        if not namespaceID == nil then
          vim.api.nvim_buf_clear_namespace(0, namespaceID, 0, -1)
        end
        require('render-markdown').setup({})
      end
  },

}

