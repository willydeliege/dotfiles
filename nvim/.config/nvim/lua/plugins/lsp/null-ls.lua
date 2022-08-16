local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local M = {}

function M.setup()
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local code_actions = null_ls.builtins.code_actions
    null_ls.setup {
        debug = false,
        sources = {
            formatting.google_java_format,
            formatting.prettier,
            formatting.eslint,
            code_actions.eslint,
        },
    }
end

return M
