return {
    "hrsh7th/cmp-nvim-lsp",
    ft = { "lua", "vue", "javascript", "razor", "cshtml" },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        -- 1. Configureer lua_ls native via Neovim v0.12
        vim.lsp.config("lua_ls", {
            cmd = { "lua-language-server" },
            -- Vertel Neovim dat deze configuratie uitsluitend voor Lua-bestanden geldt
            filetypes = { "lua" },
            -- Zoek de rootmap op basis van je .git of init.lua
            root_marker = { "init.lua", ".git" },
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
        -- =========================================================================
        -- DE BEREKENING VAN HET HARDCONCRETE WINDOWS TYPESCRIPT PAD
        -- =========================================================================
        local raw_data_path = vim.fn.stdpath("data")
        -- Volar en vtsls vereisen op Windows harde backslashes (\) naar de TypeScript lib-map
        local win_ts_lib = (raw_data_path .. [[\mason\packages\vue-language-server\node_modules\typescript\lib]]):gsub("/", "\\")

        -- 2. Configureer JavaScript/TypeScript LSP (vtsls)
        vim.lsp.config("vtsls", {
            -- CRUCIAAL OP WINDOWS: voeg .cmd toe zodat de server daadwerkelijk kan starten!
            cmd = { "vtsls.cmd", "--stdio" },
            filetypes = { "javascript", "typescript" },
            root_marker = { "package.json", ".git" },
            settings = {
                typescript = {
                    tsdk = win_ts_lib,
                },
            },
        })
        vim.lsp.enable("vtsls")

        -- 3. Configureer Vue LSP (Volar v1.x voor Vue 2)
        vim.lsp.config("vue", {
            cmd = { "vue-language-server.cmd", "--stdio" },
            filetypes = { "vue" },
            root_marker = { "package.json", ".git" },
            init_options = {
                typescript = {
                    -- DE FIX: Geef het opgeschoonde Windows-pad naar TypeScript mee.
                    -- Hierdoor start de ingebouwde JS/TS parser van Volar v1.x succesvol op!
                    tsdk = win_ts_lib,
                },
            },
        })
        vim.lsp.enable("vue")
    end,
}
