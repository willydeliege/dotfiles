-- =============================================================================
-- plugins/colorscheme.lua — Colorscheme
-- =============================================================================
-- Using catppuccin as the base theme; swap the plugin and colorscheme name to
-- use any other theme (e.g. "folke/tokyonight.nvim", colorscheme "tokyonight").
-- =============================================================================

return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark_high_contrast")
    end,
  },
}
