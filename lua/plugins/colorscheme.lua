return {
	"mofiqul/vscode.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		local vscode = require("vscode")
		local colors = require("vscode.colors").get_colors()

		local vs = {
			teal = "#4EC9B0", -- Interfaces/Delegates
			green = "#86C691", -- Structs
			lime = "#B8D7A3", -- Types/Classes
			yellow = "#DCDCAA",
		}
		vscode.setup({
			-- Overschrijf de standaardkleuren met jouw specifieke C# wensen
			group_overrides = {
				-- 1. Traditionele Syntax (Web, HTML, Markdown, Algemeen)
				["@include"] = { fg = colors.vscBlue },
				["Include"] = { fg = colors.vscFront },
				["Typedef"] = { fg = vs.teal },
				["@keyword"] = { fg = colors.vscBlue },
				["Structure"] = { fg = vs.lime },
				["Type"] = { fg = vs.teal },

				["@lsp.type.interface"] = { fg = vs.teal }, -- Interfaces (Mooi VS-Teal)
				["@lsp.type.delegate"] = { fg = vs.teal }, -- Delegates
				["@lsp.type.class"] = { fg = vs.teal }, -- Classes (VS-Lime)
				["@lsp.type.struct"] = { fg = vs.green }, -- Structs (VS-Green)
				["@lsp.type.enum"] = { fg = vs.green }, -- Enums

				["@lsp.type.property"] = { fg = colors.vscFront },
				["@lsp.type.field"] = { fg = colors.vscFront },

				-- Beheer van control keywords (zoals if, else, return, await) in het roze
				["@lsp.keyword.control"] = { fg = colors.vscPink },
				["@lsp.type.extensionMethod"] = { fg = vs.yellow },
				["@lsp.type.extensionMethod.cs"] = { fg = vs.yellow },
				["@lsp.type.method"] = { fg = vs.yellow },
				["@lsp.type.function"] = { fg = vs.yellow },
				["@lsp.mod.extension"] = { fg = vs.yellow },
				["@lsp.type.method.csharp"] = { fg = vs.yellow },
				["@lsp.type.namespace.cs"] = { fg = colors.vscFront },
			},
		})
		vscode.load("dark")
	end,
}
