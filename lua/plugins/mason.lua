return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                registries = {
                    -- De officiële, ingebouwde standaard lijst
                    "github:mason-org/mason-registry",
                    -- De extra community lijst die Roslyn server bevat
                    "github:Crashdummyy/mason-registry",
                },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        config = function()
            require("mason-tool-installer").setup({
                -- Een lijst met alle servers die Mason direct moet downloaden
                ensure_installed = { "roslyn", "lua-language-server", "vtsls",
                    { "vue-language-server", version = "1.8.27" },
                    "prettier" },
                -- Voer de installatie direct asynchroon uit bij het opstarten van Neovim
                run_on_start = true,
            })
        end,
    },
}
