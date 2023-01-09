local M = {}

function M.setup()
  local dracula = require "dracula"
  dracula.setup {
    -- customize dracula color palette
    colors = {
      bg = "#000000",
    },
    overrides = {
      -- Cursor = {},
      -- Examples
      -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
      -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
      -- Nothing = {} -- clear highlight of Nothing
    },
  }
  -- Lua:
  vim.cmd [[colorscheme dracula]]
end

return M
