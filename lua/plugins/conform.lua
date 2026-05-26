return {
    "stevearc/conform.nvim",

    event = { "BufReadPre", "BufNewFile" },

    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            vue = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
        },
    },
}
