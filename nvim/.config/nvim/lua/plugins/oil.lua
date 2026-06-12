-- =============================================================================
-- plugins/oil.lua — Oil.nvim file explorer
-- =============================================================================
-- oil.nvim lets you edit the filesystem like a buffer:
--   • Navigate into directories (Enter / -)
--   • Create, rename, delete, copy files by editing the buffer
--   • Write the buffer (:w) to apply all changes
-- =============================================================================

return {
  {
    "stevearc/oil.nvim",
    -- Load immediately so "-" works from any buffer
    lazy = false,
    keys = {
      { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory (Oil)" },
      { "<leader>-", "<cmd>Oil --float<CR>", desc = "Open Oil (float)" },
      { "<leader>fe", "<cmd>Oil --float<CR>", desc = "File explorer (Oil)" },
    },

    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
      -- ── View settings ─────────────────────────────────────────────────────────
      -- Show hidden files (toggle with `g.`)
      view_options = {
        show_hidden = false,
        -- Highlight git-ignored files differently
        is_always_hidden = function(name, _)
          return name == ".git"
        end,
      },

      -- ── Columns displayed in the oil buffer ───────────────────────────────────
      columns = {
        "icon",
        -- Uncomment to show permissions / size / modification time:
        -- "permissions",
        -- "size",
        -- "mtime",
      },

      -- ── Key bindings inside the Oil buffer ───────────────────────────────────
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent", -- Go up to parent directory
        ["_"] = "actions.open_cwd", -- Open the CWD
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" } },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      -- Disable default keymaps so only the ones above are active
      use_default_keymaps = false,

      -- ── Floating window settings ──────────────────────────────────────────────
      float = {
        border = "rounded",
      },

      -- ── Skip confirmation for simple single-file operations ───────────────────
      skip_confirm_for_simple_edits = false,

      -- ── Prompt to save before navigating away from a modified oil buffer ──────
      prompt_save_on_select_new_entry = true,
    },
  },
}
