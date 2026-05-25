vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
require("config.options")
require("config.keymaps")
require("config.lazy")

-- DE FIX VOOR DE ROSLYN -30099 ERROR
-- We overschrijven de standaard LSP-fouthandler om de Neo-tree timingfout te filteren
local original_lsp_handler = vim.lsp.handlers["window/showMessage"] or vim.lsp.handlers["window/logMessage"]
vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
    -- Controleer of het resultaat en het foutbericht bestaan, en zoek naar de foutcode
    if result and result.message and string.find(result.message, "-30099") then
        return -- Stop hier stilletjes; toon deze specifieke melding niet
    end
    -- Laat alle andere, belangrijke foutmeldingen normaal zien
    if original_lsp_handler then
        original_lsp_handler(err, result, ctx, config)
    end
end

-- Vangnet voor het geval de fout als een pure notificatie binnenkomt:
local orig_notify = vim.notify
vim.notify = function(msg, log_level, opts)
    if msg and (string.find(msg, "-30099") or string.find(msg, "textDocument/diagnostics")) then
        return -- Blokkeer de notificatie onderin het scherm
    end
    orig_notify(msg, log_level, opts)
end
