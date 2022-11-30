local M = {}

function M.setup()
  require("onedark").setup {
    style = "deep",
  }
  require("onedark").load()
end

return M
