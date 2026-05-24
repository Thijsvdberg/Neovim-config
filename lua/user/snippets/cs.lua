local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cs", "cpp" },
	callback = function()
		-- Voeg :/// toe aan de commentaarstijlen
		vim.opt_local.comments:append(":///")
		-- Zorg dat Neovim comments doortrekt bij een enter (r) en o/O (o)
		vim.opt_local.formatoptions:append("ro")
	end,
})
local function get_method_params_regex()
	local nodes = {}

	-- CONTROLE: Staan we al in een bestaand /// commentaarblok?
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local current_row = cursor_pos[1] - 1 -- 0-indexed voor de API

	-- Check de huidige regel (vóór de cursor) en de regel erboven
	local current_line = vim.api.nvim_buf_get_lines(0, current_row, current_row + 1, false)[1] or ""
	local prev_line = current_row > 0 and vim.api.nvim_buf_get_lines(0, current_row - 1, current_row, false)[1] or ""

	-- Als de regel erboven al '///' bevat, of de huidige regel bevat al '///' vóór onze sleshes,
	-- dan zijn we gewoon tekst aan het typen. Geef een lege node terug (doe niks).
	if prev_line:match("^%s*///") or current_line:match("^%s*////") then
		return sn(nil, { t("///") }) -- Typ gewoon de drie slashes en stop
	end

	-- Vanaf hier start de normale logica voor een NIEUW blok
	table.insert(nodes, t({ "/// <summary>", "/// " }))
	table.insert(nodes, i(1))
	table.insert(nodes, t({ "", "/// </summary>" }))

	local total_lines = vim.api.nvim_buf_line_count(0)
	local method_signature = ""

	-- Scan vanaf de VOLGENDE regel naar beneden
	for r = current_row + 1, math.min(current_row + 21, total_lines - 1) do
		local line_table = vim.api.nvim_buf_get_lines(0, r, r + 1, false)
		local line = line_table and line_table[1] or ""

		method_signature = method_signature .. " " .. line
		if line:match("{") or line:match(";") then
			break
		end
	end

	local params_str = method_signature:match("%((.-)%)")
	if params_str and params_str ~= "" then
		for param in string.gmatch(params_str, "[^,]+") do
			param = param:gsub("%s+", " ")
			param = param:gsub("^%s*(.-)%s*$", "%1")
			param = param:gsub("=.*$", "")
			param = param:gsub("^%s*(.-)%s*$", "%1")

			local param_name = param:match("([%a%d_]+)$")
			if param_name and param_name ~= "this" then
				table.insert(nodes, t({ "", '/// <param name="' .. param_name .. '"></param>' }))
			end
		end
	end

	return sn(nil, nodes)
end

ls.add_snippets("cs", {
	s({ trig = "///", snippetType = "autosnippet" }, {
		d(1, get_method_params_regex),
	}),
})
