return {
  -- De tabbladen-balk bovenaan je scherm
  "akinsho/bufferline.nvim",
  
  -- Zorg dat de balk direct laadt bij het opstarten
  lazy = false,
  
  -- Vereiste plugin voor de bestandstype-iconen in de tabbladen
  dependencies = { "nvim-tree/nvim-web-devicons" },
  
  config = function()
    require("bufferline").setup({
      options = {
        -- Gebruik de ingebouwde Neovim buffer-verwijdering bij het klikken/sluiten
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        
        -- De visuele actieve indicator aan de linkerkant van het actieve tabblad
        indicator = {
          style = "icon",
          icon = "▎",
        },
        
        -- Strakke, dunne scheidingslijntjes tussen de tabbladen zoals je had
        separator_style = "thin",
        
        -- Dwing alle tabbladen om exact even breed te zijn
        enforce_regular_tabs = true,
        
        -- DE NEO-TREE FIX: Zorgt dat de tabbladen pas beginnen náást je verkenner.
        -- 'highlight' zorgt dat de achtergrondkleur matcht met de zijbalk.
        offsets = {
          {
            filetype = "neo-tree",
            text = "Files",
            text_align = "center",
            highlight = "Directory",
            padding = 1,
          },
        },
      },
    })
  end,
}
