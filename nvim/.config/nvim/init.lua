-- =============================================================================
-- init.lua — Neovim 0.12 entry point
-- =============================================================================
-- Load order:
--   1. config/options   – vim.opt settings
--   2. config/keymaps   – global key mappings (no plugin deps)
--   3. config/lazy      – bootstrap lazy.nvim and load all plugins
-- =============================================================================

-- Enable ui12 features
require("vim._core.ui2").enable({
  pager = { height = 15 },
})
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
