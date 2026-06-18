-- =============================================================================
-- plugins/extras.lua — Small utility plugins
-- =============================================================================
return {
  -- ── mini.nvim collection ─────────────────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.splitjoin").setup()
      require("mini.jump2d").setup()
      require("mini.jump").setup()
      require("mini.icons").setup()
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
          add = "gsa",
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
      -- Fancy notifier
      require("mini.notify").setup()
      -- Fancy input
      require("mini.input").setup()
      vim.ui.input = require("mini.input")
      require("mini.indentscope").setup()
      require("mini.diff").setup({ view = { style = "sign" } })
      vim.keymap.set("n", "go", function()
        require("mini.diff").toggle_overlay(0)
      end, { desc = "Diff overlay" })
    end,
  },

  -- ── Git workflow  ──────────────────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
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
  {
    "lambdalisue/vim-suda",
    -- Charge le plugin immédiatement ou à l'appel d'une commande
    cmd = { "SudaRead", "SudaWrite" },
    keys = {
      { "<leader>fSr", "<cmd>SudaRead<CR>", desc = "Suda Read (sudo)" },
      { "<leader>fSw", "<cmd>SudaWrite<CR>", desc = "Suda Write (sudo)" },
    },
    init = function()
      -- Gère de manière transparente les fichiers sans droits en lecture/écriture
      vim.g.suda_smart_edit = 1
    end,
  },

  -- ── Built-in undotree  ──────────────────────────────────────────────────────────────
  {
    -- We provide a placeholder name since it doesn't pull from GitHub
    "nvim.undotree",
    virtual = true, -- Tells lazy.nvim this is a system/built-in package
    keys = {
      {
        "<leader>U",
        function()
          -- Load the built-in module safely if it hasn't been loaded yet
          if not pcall(require, "undotree") then
            vim.cmd("packadd nvim.undotree")
          end
          -- Open the undotree window split
          require("undotree").open()
        end,
        desc = "Toggle Built-in UndoTree",
      },
    },
  },
}
