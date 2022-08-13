local M = {}

function M.setup()
    --TODO move to sumneko_lua in lsp//settinsgs
    local luadev = require("lua-dev").setup {
        lspconfig = {
            on_attach = require("plugins.lsp.handlers").on_attach,
            capabilities = require("plugins.lsp.handlers").capabilities
        }

    }

    local lspconfig = require('lspconfig')
    lspconfig.sumneko_lua.setup(luadev)
end

return M
