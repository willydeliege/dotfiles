local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

--Ensure compilers for treesitter are installed
require 'nvim-treesitter.install'.compilers = { "zig", "clang", "gcc" }

configs.setup {
    ensure_installed = { "java", "lua", "html" },
    sync_install = false,
    -- NOTE: need to ignore installation of phpdoc parser because it is not ready for Mac m1 arm64 architecture
    ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
    autopairs = { enable = true },
    autotag = { enable = true },
    highlight = {
        enable = true,
        -- disable = { "css", "markdown" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}
