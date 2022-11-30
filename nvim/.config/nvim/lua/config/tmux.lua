local M ={}

function M.setup()
require("nvim-tmux-navigation").setup {
  disable_when_zoomed = false, -- defaults to false
  keybindings = {
    left = "<M-h>",
    down = "<M-j>",
    up = "<M-k>",
    right = "<M-l>",
    last_active = "<C-\\>",
    next = "<C-Space>",
  },
}
end

return M
