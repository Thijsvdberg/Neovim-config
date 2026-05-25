local opt = vim.opt
-- Visual settings
opt.number = true -- show line numbers
opt.relativenumber = true -- show relative line numbers
opt.cursorline = true -- highlights the cursor line
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showtabline = 2
opt.conceallevel = 0

-- Text wrapping
opt.wrap = true -- wraps text around
opt.linebreak = true -- break

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- System
opt.clipboard = "unnamedplus" -- Windows clipboard integration
opt.undofile = true -- enable persistent undo
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- unless explicitly typing in capital

opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
opt.iskeyword:append("-") -- hyphenated words recognized by searches
