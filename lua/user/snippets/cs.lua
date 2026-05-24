local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node

-- Helperfunctie die via Regex de parameters uit de regels eronder haalt
local function get_method_params_regex()
    local nodes = {}
    table.insert(nodes, t({ "/// <summary>", "/// " }))
    table.insert(nodes, i(1)) -- Cursor start direct in de <summary>
    table.insert(nodes, t({ "", "/// </summary>" }))

    -- Haal het huidige regelnummer op (1-indexed voor de API)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_row = cursor_pos[1] 
    local total_lines = vim.api.nvim_buf_line_count(0)
    
    -- We scannen nu maximaal 20 regels naar beneden voor lange, multi-line definities
    local method_signature = ""
    for r = current_row, math.min(current_row + 20, total_lines - 1) do
        -- vim.api.nvim_buf_get_lines gebruikt 0-indexed regels
        local line_table = vim.api.nvim_buf_get_lines(0, r, r + 1, false)
        local line = line_table and line_table[1] or ""
        
        method_signature = method_signature .. " " .. line
        
        -- Stop zodra we de body '{' of een afsluiter ';' tegenkomen
        if line:match("{") or line:match(";") then
            break
        end
    end

    -- Zoek naar alles tussen de EERSTE set haakjes (multi-line safe door %s*)
    local params_str = method_signature:match("%((.-)%)")
    
    if params_str and params_str ~= "" then
        -- Splits de parameters op basis van de komma's
        for param in string.gmatch(params_str, "[^,]+") do
            -- Sloop overbodige spaties en regeleinden (newlines) eruit
            param = param:gsub("%s+", " ")
            param = param:gsub("^%s*(.-)%s*$", "%1")
            
            -- Pak het allerlaatste woord van de parameter (de variabelenaam)
            local param_name = param:match("([%a%d_]+)$")
            
            if param_name then
                table.insert(nodes, t({ "", '/// <param name="' .. param_name .. '"></param>' }))
            end
        end
    end

    return sn(nil, nodes)
end

-- De snippet definitie
ls.add_snippets("cs", { 
    s({ trig = "///", snippetType = "autosnippet" }, {
        d(1, get_method_params_regex)
    })
})
