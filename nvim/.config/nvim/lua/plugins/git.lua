-- ~/.config/nvim/lua/plugins/gitsigns.lua
--
-- Complete gitsigns.nvim setup for lazy.nvim.
-- All git-related keymaps live under the <leader>g prefix.

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy", -- loads early enough that signs show on startup; switch to "BufReadPre" if you prefer
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,

      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,

      current_line_blame = false, -- toggle on demand with <leader>gtb
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,

      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },

      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation (kept on standard ]c / [c, works with vim.diagnostic's [ ] convention)
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next git hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous git hunk")

        -- Staging / resetting hunks
        map("n", "<leader>ghs", gs.stage_hunk, "Git un/stage hunk")
        map("v", "<leader>ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git stage hunk (selection)")

        map("n", "<leader>ghr", gs.reset_hunk, "Git reset hunk")
        map("v", "<leader>ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git reset hunk (selection)")

        map("n", "<leader>ghS", gs.stage_buffer, "Git stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Git reset buffer")

        -- Inspecting changes
        map("n", "<leader>ghp", gs.preview_hunk, "Git preview hunk")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Git blame line")
        map("n", "<leader>gtb", gs.toggle_current_line_blame, "Git toggle line blame")
        map("n", "<leader>gtd", gs.preview_hunk_inline, "Git toggle deleted lines")
        map("n", "<leader>gtw", gs.toggle_word_diff, "Git toggle word diff")

        -- Diffing
        map("n", "<leader>gd", gs.diffthis, "Git diff this")
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, "Git diff this (~)")

        -- Hunk text object, e.g. `dih` deletes the current hunk
        map({ "o", "x" }, "ih", gs.select_hunk, "Git select hunk")
      end,
    },
  },
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
}
