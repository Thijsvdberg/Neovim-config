local lush = require('lush')
local hsl = lush.hsl

o
local theme = lush(function()
  return {
    -- (You might want to disable line wrapping here via `setlocal nowrap`.)
    --
    -- Each element in the table should match this format:
    --
    --   <HighlightGroupName> { bg = <hsl>|<string>,
    --                          fg = <hsl>|<string>,
    --                          sp = <hsl>|<string>,
    --                          gui = <string>,
    --                          ... },
    --
    -- Any vim highlight group name is valid, and any unrecognized key is
    -- removed.

    -- Every theme needs a "Normal" group, so lets define that first. You can
    -- see we already have a definition prepared, so just remove uncomment the
    -- line directly after this one.
    -- Normal { bg = sea_deep, fg = sea_foam }, -- Goodbye gray, hello blue!

    -- You should immediately see your background and text color change to the
    -- colors we setup before. That's all there is to writing basic highlight groups
    -- with Lush!
    --
    -- But we can do more. Lush can use previous groups to define new ones, as
    -- well as access properties of those groups.
    --
    -- For example, lets set our CursorLine to be slightly lighter than our
    -- normal background. (If disabled: `setlocal cursorline`).
    -- We can do this by setting the background property (bg) to the Normal
    -- groups background, lightened by a few points.
    -- CursorLine { bg = Normal.bg.lighten(10) }, -- lighten() can also be called via li()
    -- Also note that (after you move your cursor away from the line) the text
    -- "CursorLine" is highlighted to match the definition, so you can always
    -- see how parts of your theme will look.

    -- We can swap colors around too, lets make our visual selection ("v mode")
    -- the inverse of Normal.
    -- Visual { fg = Normal.bg, bg = Normal.fg }, -- Try pressing v and selecting some text

    -- We can adjust our comments to look like desaturate normal text
    -- Comment { fg = Normal.bg.de(25).li(25).ro(-10) },

    -- Besides directly using group properties, we can define two relationships
    -- between groups, "link" and "inherit".
    --
    -- Link is natively supported by Neovim (see `:h hl-link`), both groups
    -- will appear the same, and changes to the "root" will effect the other.
    --
    -- Inherit groups behave similarly to link, but the parent group properties
    -- are copied to the child, and then any changed properties override the
    -- parent.

    -- For example, lets "link" CursorColumn to CursorLine.
    -- (If disabled: `setlocal cursorcolumn`)
    -- CursorColumn { CursorLine }, -- CursorColumn is linked to CursorLine

    -- Or we can make LineNr inherit from Comment, but we'll adjust the gui
    -- property (`setlocal number`)

    -- LineNr { Comment, gui = "italic" },
    -- Try writing your own above and below line number groups, and
    -- experimenting with the different operations listed at the start of this
    -- file.
    -- LineNrBelow { LineNr },
    -- LineNrAbove { LineNr },
    -- CursorLineNr { LineNr, fg = CursorLine.bg.mix(Normal.fg, 50) },

    -- Finally you can also use highlight groups to define "base" colors, if
    -- you dont want to use regular Lua variables. They will behave in the same
    -- way. Note that these groups *will* be defined as a vim-highlight-group,
    -- so try not to pick names that might end up being used by something else.
    --
    -- CamelCase is by tradition but you don't have to use it.
    -- search_base  { bg = hsl(52, 52, 52), fg = hsl(52, 10, 10) },
    -- Search       { search_base },
    -- IncSearch    { bg = search_base.bg.ro(-20), fg = search_base.fg.da(90) },
  }
end)

-- return our parsed theme for extension or use else where.
-- And that's the basics of using Lush!
return theme



-- ###
-- ### Other tools
-- ###
--
-- By default, lush() actually returns your theme as a table. You can
-- interact with it in much the same way as you can inside a lush-spec.
--
-- This looks something like:
--
--   local theme = lush(function()
--     -- define a theme
--     return {
--       Normal { fg = hsl(0, 100, 50) },
--       CursorLine { Normal },
--     }
--   end)
--
--   -- behaves the same as above:
--   theme.Normal.fg()                     -- returns table {h = h, s = s, l = l}
--   tostring(theme.Normal.fg)             -- returns "#hexstring"
--   tostring(theme.Normal.fg.lighten(10)) -- you can still modify colors, etc
--
-- This means you can `require('my_lush_file')` in any lua code to access your
-- themes's color information (including outside of neovim).
--
-- Note:
--
-- "Linked" groups do not expose their colors, you can find the key
-- of their linked group via the 'link' key (may require chaining)
--
--   theme.CursorLine.fg() -- This is bad!
--   theme.CursorLine.link   -- = "Normal"
--
-- Also Note:
--
-- Most plugins expose their own Highlight groups, which *should be the primary
-- method for setting theme colors*, there are however some plugins that
-- require adjustments to a global or configuration variable.
--
-- To set a global variable, use neovims lua bridge,
--
--   vim.g.my_plugin.color_for_widget = theme.Normal.fg.hex
--
--
-- For more information, see the README.md, CREATE.md, EXTEND.md and `:h lush`.

-- vi:nowrap:number
