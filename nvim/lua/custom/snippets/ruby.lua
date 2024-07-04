require("luasnip.session.snippet_collection").clear_snippets "ruby"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

--[[ ls.add_snippets("elixir", {
    s("el", fmt("<%= {} %>{}", { i(1), i(0) })),
    s("ei", fmt("<%= if {} do %>{}<% end %>{}", { i(1), i(2), i(0) })),
}) ]]

ls.add_snippets("ruby", {
  s("def", fmt("def {}\n\t{}\nend", { i(1, "method_name"), i(0, "body") })),
  s("defp", fmt("def {}({})\n\t{}\nend", { i(1, "method_name"), i(2, "args"), i(0, "body") })),
  s("defc", fmt("def self.{}({})\n\t{}\nend", { i(1, "method_name"), i(2, "args"), i(0, "body") })),

  s("class", fmt("class {}\n\t{}\nend", { i(1, "class_name"), i(0, "body") })),
  s("clac", fmt("class {} < ApplicationController\n\t{}\nend", { i(1, "controller_class_name"), i(0, "body") })),
  s("clai", fmt("class {}\n\tdef initialize({})\n\t\t{}\n\tend\nend", { i(1, "class_name"), i(2, "args"), i(0, "body") })),

  s("mod", fmt("module {}\n\t{}\nend", { i(1, "module_name"), i(0, "body") })),
  s("do", fmt("do |{}|\n\t{}\nend", { i(1, "args"), i(0, "body") })),
})
