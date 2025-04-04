-- 
return {
  {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {},
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
        'opdavies/toggle-checkbox.nvim'
      },
      config = function()
        require('render-markdown').setup({
            file_types = { 'markdown', 'vimwiki' },
            heading = {
              sign = false
            },
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
                    scope_highlight = '@markup.strikethrough'
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
                    started = {
                      raw = '[S]', rendered = '󰦕 ', highlight = 'RenderMarkdownWarn', scope_highlight = nil
                    },
                    deleted = {
                      raw = '[D]', rendered = ' ', highlight = 'RenderMarkdownError', scope_highlight = '@markup.strikethrough'
                    },
                    blocked = {
                      raw = '[B]', rendered = '󰲼 ', highlight = 'RenderMarkdownError', scope_highlight = '@markup.strikethrough'
                    },
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

        require('obsidian').get_client().opts.ui.enable = false
        local namespaceID = vim.api.nvim_get_namespaces()["ObsidianUI"]
        if not namespaceID == nil then
          vim.api.nvim_buf_clear_namespace(0, namespaceID, 0, -1)
        end
        require('render-markdown').setup({})
        vim.keymap.set("n", "<space><space>", ":lua require('toggle-checkbox').toggle()<CR>")
      end
  },

}

