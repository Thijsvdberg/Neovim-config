return {
    "seblj/roslyn.nvim",
    ft = { "cs", "csproj", "razor", "cshtml" },
    dependencies = {
        {
            -- By loading as a dependencies, we ensure that we are available to set
            -- the handlers for Roslyn.
            "tris203/rzls.nvim",
        },
    },
    config = function()
        local raw_data_path = vim.fn.stdpath("data")
        local rzls_path = vim.fs.normalize(raw_data_path ..
            "/mason/packages/roslyn/libexec/Microsoft.CodeAnalysis.LanguageServer")
        require("roslyn").setup({
            cmd = {
                "roslyn",
                "--stdio",
                "--logLevel=Information",
                "--extensionLogDirectory=" .. vim.fs.normalize(vim.lsp.get_log_path()),
                -- Prik de compiler en design-time targets die al op je schijf staan direct aan:
                "--razorSourceGenerator=" .. vim.fs.normalize(rzls_path .. "/Microsoft.CodeAnalysis.Razor.Compiler.dll"),
                "--razorDesignTimePath=" ..
                vim.fs.normalize(rzls_path .. "/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets"),
            },
            config = {
                handlers = require("rzls.roslyn_handlers"),
                -- Geef de autocomplete capabilities mee
                capabilities = vim.lsp.protocol.make_client_capabilities(),

                settings = {
                    ["csharp|background_analysis"] = {
                        -- Analyseer alleen open bestanden voor maximale snelheid in grote codebases
                        dotnet_analyzer_diagnostics_scope = "openFiles",
                        dotnet_compiler_diagnostics_scope = "fullSolution",
                    },
                },
            },
        })
    end,
    init = function()
        -- Zorg dat Neovim bij het opstarten snapt dat cshtml onder de 'razor' vlag valt
        vim.filetype.add({
            extension = {
                razor = "razor",
                cshtml = "razor",
            },
        })
    end,
}
