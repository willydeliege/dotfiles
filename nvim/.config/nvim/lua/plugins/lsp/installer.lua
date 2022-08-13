local M = {}

function M.setup(servers, options)
  local lspconfig = require "lspconfig"
--  local icons = require "config.icons"

  require("mason").setup {
    --ui = {
  --    icons = {
    --    package_installed = icons.server_installed,
      --  package_pending = icons.server_pending,
        --package_uninstalled = icons.server_uninstalled,
      --,
   -- },
  }

--  require("mason-tool-installer").setup {
  --  ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "prettierd" },
    -- auto_update = false,
   -- run_on_start = true,
  --}

  require("mason-lspconfig").setup {
--    ensure_installed = vim.tbl_keys(servers),
     -- automatic_installation = false,
  }


        local luadev = require("plugins.lsp.lua-dev").setup()

lspconfig.sumneko_lua.setup(luadev)
end
