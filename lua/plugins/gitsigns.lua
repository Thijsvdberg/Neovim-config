return {
  -- De plugin voor live Git-statussen in de kantlijn
  "lewis6991/gitsigns.nvim",
  
  -- Laad de plugin zodra er tekst in een buffer wordt geladen (werkt overal waar Git actief is)
  event = { "BufReadPre", "BufNewFile" },
  
  config = function()
    require("gitsigns").setup({
      -- Jouw vertrouwde, specifieke Git Nerd-Font icoontjes
      signs = {
        add          = { text = " " },
        change       = { text = " " },
        delete       = { text = " " },
        topdelete    = { text = "   " },
        changedelete = { text = "   " },
        untracked    = { text = "┆" },
      },
      
      -- Toon Git-indicatoren ook bij bestanden die nog niet gepusht/ge-trackt zijn
      attach_to_untracked = true,
      
      -- Instellingen voor de zwevende Git-vensters (zoals bij het bekijken van een wijziging)
      preview_config = {
        border = "rounded", -- Mooie afgeronde hoeken in plaats van de strakke 'single' rand
      },
    })
  end,
}
