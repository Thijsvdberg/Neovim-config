return {
    "folke/which-key.nvim",
    lazy = false,

    config = function()
        local wk = require("which-key")
        wk.setup()

        wk.add({

            -- buffers
            {
                "<leader>c",
                "<cmd>bdelete<CR>",
                desc = "Close Buffer",
            },
            {
                "<leader>bd",
                "<cmd><CR>",
                desc = "Close all buffers except current",
            },
            {
                "<leader>bl",
                "<cmd><CR>",
                desc = "List all buffers",
            },



            -- git
            { "<leader>g",  group = "GIT" },
            { "<leader>gj", function() require("gitsigns").next_hunk() end,       desc = "Next Hunk" },
            { "<leader>gk", function() require("gitsigns").prev_hunk() end,       desc = "Prev Hunk" },
            { "<leader>gl", function() require("gitsigns").blame_line() end,      desc = "Blame Line" },
            { "<leader>gp", function() require("gitsigns").preview_hunk() end,    desc = "Preview Hunk" },
            { "<leader>gr", function() require("gitsigns").reset_hunk() end,      desc = "Reset Hunk" },
            { "<leader>gR", function() require("gitsigns").reset_buffer() end,    desc = "Reset Buffer" },
            { "<leader>gs", function() require("gitsigns").stage_hunk() end,      desc = "Stage Hunk" },
            { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage Hunk" },
            { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                    desc = "Diff HEAD" },

            -- LSP
            { "<leader>l",  group = "LSP" },
            { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",             desc = "Code Action" },
            { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>",        desc = "Format" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                  desc = "Rename" },
            { "<leader>le", "<cmd>lua vim.lsp.buf.definition()<cr>",              desc = "Goto definition" },
            { "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<cr>",             desc = "Goto declaration" },
            { "<leader>lt", "<cmd>lua vim.lsp.buf.implementation()<cr>",          desc = "Goto implementation" },
            { "<leader>lu", "<cmd>lua vim.lsp.buf.references()<cr>",              desc = "Find references" },
            { "<leader>lq", "<cmd>lua vim.lsp.buf.hover()<cr>",                   desc = "Symbol info" },
            { "<leader>li", "<cmd>lua vim.diagnostic.open_float()<cr>",           desc = "Dianostics info" },
        })
    end,
}
