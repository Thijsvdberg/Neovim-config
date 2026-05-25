return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	keys = {
		{ "<leader>f", "<cmd>lua _G.get_telescope_lsp_root('find_files')<cr>", desc = "Bestand zoeken (Slimme Root)" },
		{ "<leader>F", "<cmd>lua _G.get_telescope_lsp_root('live_grep')<cr>", desc = "Tekst zoeken (Slimme Root)" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- We registreren een GLOBALE functie (_G) zodat Vim-commando's erbij kunnen
		_G.get_telescope_lsp_root = function(picker_type)
			local search_dirs = {}

			-- Scan all active LSP clients for the current buffer and get all the search dirs
			local active_clients = vim.lsp.get_clients({ bufnr = 0 })
			for _, client in ipairs(active_clients) do
				if client.config and client.config.root_dir then
					local p = vim.fs.normalize(client.config.root_dir)
					if not vim.tbl_contains(search_dirs, p) then
						table.insert(search_dirs, p)
					end
				end
				if client.workspace_folders then
					for _, folder in ipairs(client.workspace_folders) do
						local p = vim.fs.normalize(vim.uri_to_fname(folder.uri))
						if not vim.tbl_contains(search_dirs, p) then
							table.insert(search_dirs, p)
						end
					end
				end
			end

			local target_cwd = nil
			if #search_dirs > 0 then
				target_cwd = search_dirs[1] -- Pak de hoofdmap van de actieve LSP
			else
				-- Fallback use git root folder
				local git_root = vim.fs.root(0, { ".git" })
				if git_root then
					target_cwd = vim.fs.normalize(git_root)
				end
			end

			if picker_type == "find_files" then
				require("telescope.builtin").find_files({
					cwd = target_cwd,
					theme = "dropdown",
				})
			elseif picker_type == "live_grep" then
				require("telescope.builtin").live_grep({
					cwd = target_cwd,
				})
			end
		end

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",

				path_display = { "filename_first" },

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},
		})
	end,
}
