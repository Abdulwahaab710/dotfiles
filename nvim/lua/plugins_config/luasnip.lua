-- if vim.g.sippets ~= "luasnip" then
--   return
-- end

require("luasnip.loaders.from_vscode").lazy_load()

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  history = true,

  updateevents = "TextChanged,TextChangedI",

  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      }
    }
  }
}

vim.keymap.set({"i", "s"}, "<c-s>", function()
  ls.expand_or_jump()
  --[[ if ls.expand_or_jumpable() then
    ls.expand_or_jumpable()
  end ]]
end, { silent = true })
