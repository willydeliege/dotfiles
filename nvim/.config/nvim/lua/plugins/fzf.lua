-- =============================================================================
-- plugins/fzf-lua.lua — Fuzzy finder powered by fzf
-- =============================================================================
-- fzf-lua provides fast fuzzy finding for:
--   files, buffers, git, LSP symbols, grep, and more.
-- Requires fzf to be installed on the system: https://github.com/junegunn/fzf
-- Optional but recommended: ripgrep (rg) for live grep, fd for file finding.
-- =============================================================================

return {
  {
    "ibhagwan/fzf-lua",
    -- Load on demand; keymaps and which-key trigger the load
    cmd = "FzfLua",
    keys = {
      -- ── Find / Files ────────────────────────────────────────────────────────
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      {
        "<leader>fr",
        function()
          require("fzf-lua").oldfiles({
            cwd_only = true,
            stat_file = true, -- vérifie que le fichier existe toujours sur le disque
          })
        end,
        desc = "Recent files (cwd only)",
      },
      { "<leader>fR", "<cmd>FzfLua oldfiles<CR>", desc = "All recent files" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
      { "<leader>fg", "<cmd>FzfLua git_files<CR>", desc = "Find git files" },
      { "<leader>ft", "<cmd>FzfLua filetypes<CR>", desc = "Change filetype" },

      -- ── Search ──────────────────────────────────────────────────────────────
      {
        "<leader>sb",
        function()
          require("fzf-lua").blines({
            winopts = {
              height = 0.35,
              width = 1.0,
              row = 1.0,
              ---@diagnostic disable-next-line: missing-fields
              preview = {
                hidden = true,
              },
            },
          })
        end,
        desc = "Buffer Lines (Ivy mode)",
      },
      { "<leader>/", "<cmd>FzfLua live_grep<CR>", desc = "Grep project" },
      { "<leader>sg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD under cursor" },
      { "<leader>sv", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "Grep selection" },
      { "<leader>sr", "<cmd>FzfLua resume<CR>", desc = "Resume last search" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "LSP symbols (doc)" },
      { "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", desc = "LSP symbols (workspace)" },
      { "<leader>sc", "<cmd>FzfLua command_history<CR>", desc = "Command history" },
      { "<leader>s/", "<cmd>FzfLua search_history<CR>", desc = "Search history" },
      { "<leader>:", "<cmd>FzfLua command_history<CR>", desc = "Command history" },
      { "<leader>sm", "<cmd>FzfLua marks<CR>", desc = "Marks" },

      -- ── Help ─────────────────────────────────────────────────────────────────
      { "<leader>hh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
      { "<leader>hc", "<cmd>FzfLua commands<CR>", desc = "Commands" },
      { "<leader>hk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
      { "<leader>hm", "<cmd>FzfLua manpages<CR>", desc = "Man pages" },
      { "<leader>ha", "<cmd>FzfLua autocmds<CR>", desc = "Autocomands" },
      { "<leader>ho", "<cmd>FzfLua nvim_options<CR>", desc = "Options" },
      -- ── Git ─────────────────────────────────────────────────────────────────
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
      { "<leader>gt", "<cmd>FzfLua git_tags<cr>", desc = "Git tags" },
      -- ── Git ─────────────────────────────────────────────────────────────────
      { "<leader>f<space>", "<cmd>FzfLua<cr>", desc = "FzfLua" },
    },

    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({

        -- ── Key bindings inside the fzf window ───────────────────────────────
        keymap = {
          fzf = {
            -- Multi-select all / toggle
            ["ctrl-a"] = "select-all+accept",
          },
        },

        -- ── Files ─────────────────────────────────────────────────────────────
        files = {
          -- Use fd if available, fall back to find
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },

        -- ── Live grep (ripgrep) ───────────────────────────────────────────────
        grep = {
          file_icons = true,
          color_icons = true,
        },

        -- ── LSP ───────────────────────────────────────────────────────────────
        lsp = {
          jump_to_single_result = true, -- Skip the picker when there's only one match
          ignore_current_line = true,
        },
      })
      fzf.register_ui_select()
    end,
  },
}
