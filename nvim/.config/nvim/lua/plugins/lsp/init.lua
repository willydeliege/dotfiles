---@diagnostic disable: missing-parameter
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
local handlers = require("plugins.lsp.handlers")
local installer = require("plugins.lsp.installer")
local nullls = require("plugins.lsp.null-ls")
installer.setup()
handlers.setup()
nullls.setup()

