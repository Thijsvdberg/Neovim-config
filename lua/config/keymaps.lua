local keymap = vim.keymap.set

-- Normal --
-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Window resizing
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^")
keymap("v", ">", ">gv^")

-- Visual Block --
-- More lines up or down
keymap("x", "J", ":m '>+1<CR>gv=gv")
keymap("x", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf", -- 'qf' staat voor Quickfix (en ook de Location List)
    callback = function(args)
        -- Koppel de 'q' toets binnen deze buffer aan het sluit-commando :cclose
        vim.keymap.set("n", "q", "<cmd>cclose<cr>", {
            buffer = args.buf,
            silent = true,
            desc = "Sluit Quickfix-lijst"
        })
    end,
})
