local keymap = vim.api.nvim_set_keymap

-- general keymap from yarepl
keymap('n', '<Leader>as', '<Plug>(REPLStart-aider)', {
    desc = 'Start an aider REPL',
})
keymap('n', '<Leader>af', '<Plug>(REPLFocus-aider)', {
    desc = 'Focus on aider REPL',
})
keymap('n', '<Leader>ah', '<Plug>(REPLHide-aider)', {
    desc = 'Hide aider REPL',
})
keymap('v', '<Leader>ar', '<Plug>(REPLSendVisual-aider)', {
    desc = 'Send visual region to aider',
})
keymap('n', '<Leader>arr', '<Plug>(REPLSendLine-aider)', {
    desc = 'Send lines to aider',
})
keymap('n', '<Leader>ar', '<Plug>(REPLSendOperator-aider)', {
    desc = 'Send Operator to aider',
})

-- special keymap from aider
keymap('n', '<Leader>ae', '<Plug>(AiderExec)', {
    desc = 'Execute command in aider',
})
keymap('n', '<Leader>ay', '<Plug>(AiderSendYes)', {
    desc = 'Send y to aider',
})
keymap('n', '<Leader>an', '<Plug>(AiderSendNo)', {
    desc = 'Send n to aider',
})
keymap('n', '<Leader>ap', '<Plug>(AiderSendPaste)', {
    desc = 'Send /paste to aider',
})
keymap('n', '<Leader>aa', '<Plug>(AiderSendAbort)', {
    desc = 'Send abort to aider',
})
keymap('n', '<Leader>aq', '<Plug>(AiderSendExit)', {
    desc = 'Send exit to aider',
})
keymap('n', '<Leader>ag', '<cmd>AiderSetPrefix<cr>', {
    desc = 'set aider prefix',
})
keymap('n', '<Leader>ama', '<Plug>(AiderSendAskMode)', {
    desc = 'Switch aider to ask mode',
})
keymap('n', '<Leader>amA', '<Plug>(AiderSendArchMode)', {
    desc = 'Switch aider to architect mode',
})
keymap('n', '<Leader>amc', '<Plug>(AiderSendCodeMode)', {
    desc = 'Switch aider to code mode',
})
keymap('n', '<Leader>aG', '<cmd>AiderRemovePrefix<cr>', {
    desc = 'remove aider prefix',
})
keymap('n', '<Leader>a<space>', '<cmd>checktime<cr>', {
    desc = 'sync file changes by aider to nvim buffer',
})

return {
  {
    'milanglacier/yarepl.nvim',
    config = function()
      require('yarepl').setup({
        -- see `:h buflisted`, whether the REPL buffer should be buflisted.
        buflisted = true,
        -- whether the REPL buffer should be a scratch buffer.
        scratch = true,
        -- the filetype of the REPL buffer created by `yarepl`
        ft = 'REPL',
        -- How yarepl open the REPL window, can be a string or a lua function.
        -- See below example for how to configure this option
        wincmd = 'belowright 15 split',
        -- The available REPL palattes that `yarepl` can create REPL based on.
        -- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
        metas = {
          aichat = { cmd = 'aichat', formatter = 'bracketed_pasting', source_func = 'aichat' },
          ruby = { cmd = 'ruby', formatter = 'trim_empty_lines', source_func = 'ruby' },
          bash = {
            cmd = 'bash',
            formatter = vim.fn.has 'linux' == 1 and 'bracketed_pasting' or 'trim_empty_lines',
            source_func = 'bash',
          },
          zsh = { cmd = 'zsh', formatter = 'bracketed_pasting', source_func = 'bash' },
        },
        -- when a REPL process exits, should the window associated with those REPLs closed?
        close_on_exit = true,
        -- whether automatically scroll to the bottom of the REPL window after sending
        -- text? This feature would be helpful if you want to ensure that your view
        -- stays updated with the latest REPL output.
        scroll_to_bottom_after_sending = true,
        -- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
        format_repl_buffers_names = true,
        os = {
          -- Some hacks for Windows. macOS and Linux users can simply ignore
          -- them. The default options are recommended for Windows user.
          windows = {
            -- Send a final `\r` to the REPL with delay,
            send_delayed_cr_after_sending = true,
          },
        }
      })
    end,
  }
}
