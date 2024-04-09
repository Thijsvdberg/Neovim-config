local ls = require("luasnip")
local from_lua = require("luasnip.loaders.from_lua")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
--[[
ls.config.set_config({
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
})
]]
ls.add_snippets(nil, {
    all = {
        ls.parser.parse_snippet("lf", "var $1 = delegate($2)\n{\n  $0\n};;;;\n"),
    },
})


from_lua.load({ paths = "./lua/user/snippets" })
