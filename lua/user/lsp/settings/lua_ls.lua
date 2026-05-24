return {
	settings = {
		Lua = {
			telemetry = { enable = false },
		},
	},

	-- Dynamische controle bij het openen van een project
	on_init = function(client)
		-- Veiligere manier om het projectpad op te vragen in v0.8.3
		local path = client.config.root_dir
			or (client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name)

		if not path then
			return true
		end

		-- Controleer of er GEEN handmatige luarc aanwezig is
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			-- Zorg dat de structuur ALTIJD begint met de 'Lua' key!
			local new_settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" }, -- Dit gaat de waarschuwing nu écht oplossen
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
							vim.fn.stdpath("data") .. "/site/pack/packer/start",
						},
						maxPreload = 2000,
						preloadFileSize = 1000,
					},
				},
			}

			-- Combineer de basisinstellingen met de nieuwe Neovim-specifieke instellingen
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, new_settings)

			-- Breng de server op de hoogte van de gewijzigde tabel
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end

		return true
	end,
}
