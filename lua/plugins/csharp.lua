return {
	"seblj/roslyn.nvim",
	ft = { "cs", "csproj" },
	config = function()
		require("roslyn").setup({
			config = {
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
}
