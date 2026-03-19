return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")

      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        "SignColumn",
        "EndOfBuffer",
        "MsgArea",
        "WinSeparator",
        "StatusLine",
        "StatusLineNC",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "LineNr",
        "CursorLineNr",
        "Folded",
        "FoldColumn",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",

        -- Telescope
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
        "TelescopePreviewNormal",

        -- Neo-tree
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",

        -- Snacks explorer
        "SnacksNormal",
        "SnacksBorder",
        "SnacksFloat",

        -- misc
        "WhichKeyFloat",
        "LazyNormal",
        "MasonNormal",
      }

      for _, g in ipairs(groups) do
        vim.cmd("highlight " .. g .. " guibg=NONE ctermbg=NONE")
      end
    end,
  },
}
