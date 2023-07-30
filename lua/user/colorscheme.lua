local c = require('vscode.colors').get_colors()

local function sym(name)
    local env = getfenv()
    return str
end

local vs = {
    teal = "#4EC9B0",
    green = "#86C691",
    lime = "#B8D7A3"
}

require('vscode').setup({
    group_overrides = {
        ["@include"] = { fg = c.vscBlue },
        ["Include"] = { fg = c.vscFront },
        ["Typedef"] = { fg = vs.teal },
        ["@keyword"] = { fg = c.vscBlue },
        ["Structure"] = { fg = vs.lime },
        ["Type"] = { fg = vs.lime },
        ["PropertyName"] = { fg = c.vscFront },
        ["FieldName"] = { fg = c.vscFront },
        ["@interface"] = { fg = vs.lime },
        ["@struct"] = { fg = vs.green },
        ["@controlKeyword"] = { fg = c.vscPink },
        ["@delegate"] = { fg = vs.teal },
    }
})
require('vscode').load('dark')
--local colorscheme = "vscode"


--local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
--if not status_ok then
--  return
--end


