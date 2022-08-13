---@diagnostic disable: missing-parameter
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
local handlers = require("plugins.lsp.handlers")
local installer = require("plugins.lsp.installer")
local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}
installer.setup()
handlers.setup()

require "plugins.lsp.null-ls"

