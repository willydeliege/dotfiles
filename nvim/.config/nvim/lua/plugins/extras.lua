-- =============================================================================
-- plugins/extras.lua — Small utility plugins
-- =============================================================================
-- This file groups minor plugins that don't warrant their own file:
--   • mini.pairs   — Auto-close brackets/quotes
--   • mini.surround — Surround text objects
--   • mini.comment  — Smart commenting (gcc / gc)
--   • gitsigns     — Git hunks in the gutter
--   • todo-comments — Highlight TODO/FIXME/NOTE comments
-- =============================================================================

return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false, -- Désactive l'autocmd obsolète pour de meilleures performances
    },
  },
  -- ── mini.nvim collection ─────────────────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    event = "VeryLazy",
    config = function()
      require("mini.jump2d").setup()
      require("mini.jump").setup()
      require("mini.icons").setup()
      local ai = require("mini.ai")

      ai.setup({
        n_lines = 500, -- Range size to scan around the cursor
        custom_textobjects = {
          -- 1. Functions (af / if)
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),

          -- 2. Classes / Blocks (ac / ic)
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

          -- 3. Function Parameters / Arguments (aa / ia)
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),

          -- 4. Function Calls (vaf / vif)
          F = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),

          -- 5. Code blocks, Loops, and Conditionals (ao / io)
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),

          -- 6. Comments (am / im)
          m = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
        },
      })
      -- Auto-pairs: inserts the closing bracket/quote automatically
      require("mini.pairs").setup({
        -- Disable auto-pair inside specific filetypes
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
      })

      -- Surround: add/delete/replace surrounding characters
      -- sa{motion}{char} → add | sd{char} → delete | sr{old}{new} → replace
      require("mini.surround").setup({
        mappings = {
          ad = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      })

      require("mini.cmdline").setup()
      -- Comment: toggle comments with gcc (line) or gc{motion}
      require("mini.comment").setup({
        options = {
          -- Use Treesitter to detect the correct comment string in mixed filetypes
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
      -- Fancy notifier
      require("mini.notify").setup()
      -- Fancy input
      require("mini.input").setup()
      vim.ui.input = require("mini.input")
      require("mini.statusline").setup()
      require("mini.indentscope").setup()
      require("mini.diff").setup({ view = { style = "sign" } })
      vim.keymap.set("n", "go", function()
        require("mini.diff").toggle_overlay(0)
      end, { desc = "Diff overlay" })
    end,
  },

  -- ── Git workglow  ──────────────────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- ── TODO / FIXME / HACK comment highlights ────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰋽 ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        multiline = true,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
      },
    },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next TODO comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev TODO comment",
      },
      { "<leader>st", "<cmd>TodoFzfLua<CR>", desc = "TODO comments (fzf)" },
    },
  },
}
