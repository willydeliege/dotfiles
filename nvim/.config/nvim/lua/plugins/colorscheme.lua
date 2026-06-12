-- =============================================================================
-- plugins/colorscheme.lua — Colorscheme
-- =============================================================================
-- Using catppuccin as the base theme; swap the plugin and colorscheme name to
-- use any other theme (e.g. "folke/tokyonight.nvim", colorscheme "tokyonight").
-- =============================================================================

return {
  {
    "catppuccin/nvim",
    name = "catppuccin-mocha",
    lazy = false, -- Load at startup
    priority = 1000, -- Load before all other plugins
    opts = {
      flavour = "mocha", -- latte | frappe | macchiato | mocha
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = "#000000", -- Fond noir absolu pour un contraste maximal
          mantle = "#0b0b0b", -- Fond des fenêtres secondaires très sombre
          crust = "#111111", -- Bordures et statuts sombres
          text = "#ffffff", -- Texte principal blanc pur (au lieu de gris clair)
        },
      },
      custom_highlights = function(colors)
        return {
          -- #8087a2 est un gris moyen très lisible (au lieu du gris très sombre par défaut)
          LineNr = { fg = "#8087a2" },

          -- Optionnel : applique une couleur éclatante (ex: jaune) à la ligne active
          CursorLineNr = { fg = colors.yellow, style = { "bold" } },
        }
      end,
      integrations = {
        blink_cmp = true,
        fzf = true,
        lualine = true,
        mason = true,
        treesitter = true,
        which_key = true,
        lsp_trouble = false,
      },
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
