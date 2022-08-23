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
    lspconfig.lemminx.setup {}
    lspconfig.tsserver.setup {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities
    }
    --Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require 'lspconfig'.bashls.setup {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities
    }
    require 'lspconfig'.html.setup {
        capabilities = capabilities,
    }
    --Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require 'lspconfig'.jsonls.setup {
        capabilities = capabilities,
    }
end

return M
