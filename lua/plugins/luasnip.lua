return {
    "L3MON4D3/LuaSnip",
    version = "v2.5.*",
    build = "make install_jsregexp",
    event = "InsertEnter",

    opts = {
        enable_autosnippets = true,
    },

    config = function(_, opts)
        local ls = require("luasnip")
        local s = ls.snippet
        local sn = ls.snippet_node
        local i = ls.insert_node
        local t = ls.text_node
        local d = ls.dynamic_node

        ls.config.set_config(opts)

        -- Automatically detect a comment when typing ///
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "cs", "cpp" },
            callback = function()
                vim.opt_local.comments:append(":///")
                vim.opt_local.formatoptions:append("ro")
            end,
        })

        -- Detect parameters using LSP and generate comment block
        local function get_method_params_regex()
            local nodes = {}
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local current_row = cursor_pos[1] - 1 -- 0-indexed for Neovim API

            local current_line = vim.api.nvim_buf_get_lines(0, current_row, current_row + 1, false)[1] or ""
            local prev_line = current_row > 0 and vim.api.nvim_buf_get_lines(0, current_row - 1, current_row, false)[1] or
            ""

            -- Check if we're already inside a comment block
            if prev_line:match("^%s*///") or current_line:match("^%s*////") then
                return sn(nil, { t("///") }) -- Just return 3 slashes
            end

            -- Start new comment block
            table.insert(nodes, t({ "/// <summary>", "/// " }))
            table.insert(nodes, i(1)) -- Cursor position 1
            table.insert(nodes, t({ "", "/// </summary>" }))

            local total_lines = vim.api.nvim_buf_line_count(0)
            local method_signature = ""

            -- Scan down for the method structure (max 21 rows atm)
            for r = current_row + 1, math.min(current_row + 21, total_lines - 1) do
                local line_table = vim.api.nvim_buf_get_lines(0, r, r + 1, false)
                local line = line_table and line_table[1] or ""

                method_signature = method_signature .. " " .. line
                if line:match("{") or line:match(";") then
                    break
                end
            end

            -- Get all the paramters between ()
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


        -- C# comments
        ls.add_snippets("cs", {
            s({ trig = "///", snippetType = "autosnippet" }, {
                d(1, get_method_params_regex),
            }),
        })
    end,


}
