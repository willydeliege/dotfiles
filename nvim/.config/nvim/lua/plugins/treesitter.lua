-- =============================================================================
-- plugins/treesitter.lua — Native Treesitter configuration
-- =============================================================================
-- nvim-treesitter provides:
--   • Improved syntax highlighting
--   • Indentation
--   • Text objects (select/move by function, class, etc.)
-- =============================================================================
return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  dependencies = {
    -- parser support
    "nvim-treesitter/nvim-treesitter",

    -- only provides textobject queries
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = function()
    local ai = require("mini.ai")
    local ts = ai.gen_spec.treesitter

    return {
      n_lines = 500,

      -- Better than the default in most cases
      search_method = "cover",

      custom_textobjects = {
        f = ts({
          a = "@function.outer",
          i = "@function.inner",
        }),

        c = ts({
          a = "@class.outer",
          i = "@class.inner",
        }),

        o = ts({
          a = {
            "@conditional.outer",
            "@loop.outer",
            "@block.outer",
          },
          i = {
            "@conditional.inner",
            "@loop.inner",
            "@block.inner",
          },
        }),

        a = ts({
          a = "@parameter.outer",
          i = "@parameter.inner",
        }),

        C = ts({
          a = "@call.outer",
          i = "@call.inner",
        }),
      },
    }
  end,
}
