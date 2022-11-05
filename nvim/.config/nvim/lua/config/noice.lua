local M = {}

function M.setup()
  require("noice").setup {

    cmdline = {
      enabled = false, -- enables the Noice cmdline UI
      view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    },
  }
end

return M
