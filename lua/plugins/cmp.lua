return {
    "hrsh7th/nvim-cmp",
    branch = "main",
    event = "InsertEnter",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- Suggesties vanuit je actieve LSP's (zoals Roslyn en Vue)
        "hrsh7th/cmp-buffer",       -- Suggesties op basis van tekst in je huidige bestand
        "hrsh7th/cmp-path",         -- Suggesties voor bestandspaden bij het typen van bijv. / of ./
        "saadparwaiz1/cmp_luasnip", -- Koppeling tussen de snippet-engine en het cmp-menu
        "L3MON4D3/LuaSnip",         -- De daadwerkelijke snippet-engine
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = " ",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = " ",
            Misc = " ",
        }
        cmp.setup({
            snippit = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),

                ["<C-u>"] = cmp.mapping.select_prev_item({ count = 10 }),
                ["<C-d>"] = cmp.mapping.select_next_item({ count = 10 }),

                ["<C-b>"] = cmp.mapping.scroll_docs(-1),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-t>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                ["<C-l>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        luasnip = "[Snippit]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- LSP suggesties hebben altijd de hoogste prioriteit
                { name = "luasnip" },  -- Snippets
                { name = "buffer" },   -- Lokale tekst
                { name = "path" },     -- Paden
            }),
            window = {},
        })
    end,
}
