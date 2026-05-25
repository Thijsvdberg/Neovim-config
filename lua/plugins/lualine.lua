return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    -- 1. FILTER: Controleert of het venster breed genoeg is (> 80 karakters)
    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    -- 2. CUSTOM COMPONENT: Jouw unieke visuele voortgangs-blokje
    local progress_bar = function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end

    -- 3. CUSTOM COMPONENT: Toont de actieve tab/spatie grootte (bijv. spaces: 4)
    local spaces = function()
      -- Moderne v0.12 API om de shiftwidth op te vragen
      return "spaces: " .. vim.bo.shiftwidth
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        -- Strakke weergave: geen harde tussenschotten tussen componenten
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        
        -- Schakel de globale statusbalk in (1 balk onderin, ideaal bij splits)
        globalstatus = true,
        
        -- Verberg de statusbalk in specifieke hulpvensters
        disabled_filetypes = { 
          statusline = { "neo-tree", "alpha", "dashboard" } 
        },
      },
      sections = {
        -- Kant links: Jouw Git Branch + de LSP Foutmeldingen (gegroepeerd)
        lualine_a = {
          { "branch", icon = "" },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " " },
          },
        },
        
        -- Modus weergave in de klassieke '-- NORMAL --' stijl van jou
        lualine_b = {
          {
            "mode",
            fmt = function(str) return "-- " .. str .. " --" end,
          },
        },
        
        -- Midden-links: Bestandsnaam inclusief het relatieve pad vanaf de Git root
        lualine_c = {
          { "filename", path = 1 }
        },
        
        -- Midden-rechts: Git wijzigingen, tab-grootte, encoding en bestandstype
        lualine_x = {
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            cond = hide_in_width, -- Verbergt dit automatisch als je je scherm splitst!
          },
          spaces,
          "encoding",
          { "filetype", icons_enabled = false }, -- Bestandstype zonder icoon zoals jij had
        },
        
        -- Kant rechts: Waar ben je (Regel : Kolom) + jouw vette progress bar!
        lualine_y = { { "location", padding = 0 } },
        lualine_z = { progress_bar },
      },
    })
  end,
}
