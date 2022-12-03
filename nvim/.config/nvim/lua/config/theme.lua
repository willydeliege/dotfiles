local M = {}

function M.setup()
  local dracula = require "dracula"
  dracula.setup {
    -- customize dracula color palette
    colors = {
      bg = "#000000",
    },
  }
  -- Lua:
  vim.cmd [[colorscheme dracula]]
end

return M
