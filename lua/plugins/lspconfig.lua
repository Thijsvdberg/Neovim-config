return {
    "hrsh7th/cmp-nvim-lsp",
    ft = { "lua" },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- 1. Configureer lua_ls native via Neovim v0.12
        vim.lsp.config("lua_ls", {
            cmd = { "lua-language-server" },
            -- Vertel Neovim dat deze configuratie uitsluitend voor Lua-bestanden geldt
            filetypes = { "lua" },
            -- Zoek de rootmap op basis van je .git of init.lua
            root_marker = { "init.lua", ".git" },
            capabilities = capabilities,
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    diagnostics = {
                        disable = { "missing-fields" },
                    },
                },
            },

        })
        vim.lsp.enable("lua_ls")
    end,
}
