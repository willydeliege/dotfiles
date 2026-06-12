-- =============================================================================
-- plugins/lsp.lua — Native LSP setup (Lua, Markdown, Bash)
-- =============================================================================
-- Uses:
--   • mason.nvim          — install/manage LSP servers
--   • lazydev.nvim        — Lua LSP enhancements for Neovim plugin development
--   • mason-lspconfig     — bridge between mason and lspconfig
--   • nvim-lspconfig      — configure each server
-- =============================================================================

return {
  -- ── Mason: LSP server installer ─────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>M", "<cmd>Mason<CR>", desc = "Open Mason" } },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ── lazydev: Neovim Lua API completions ─────────────────────────────────────
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Load the Neovim runtime (vim.*) types automatically
        { path = "lazy.nvim" },
      },
    },
  },
  -- ── Mason <-> lspconfig bridge ───────────────────────────────────────────────
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Servers that Mason will install automatically
      ensure_installed = {
        "lua_ls", -- Lua
        "marksman", -- Markdown
        "bashls", -- Bash / Shell
      },

      -- Neovim 0.12 + mason-lspconfig automatically executes `vim.lsp.enable()`
      -- for servers installed via Mason without needing nvim-lspconfig boilerplate.
      -- handlers = {
      --   function(server_name)
      --     -- Fetch blink.cmp capabilities to feed natively into the LSP client
      --     local capabilities = require("blink.cmp").get_lsp_capabilities()
      --
      --     -- Configure natively using Neovim 0.12 core API
      --     vim.lsp.config(server_name, {
      --       capabilities = capabilities,
      --     })
      --   end,
      --
      --   -- Custom target override for LuaLS to let lazydev handle settings
      --   ["lua_ls"] = function()
      --     local capabilities = require("blink.cmp").get_lsp_capabilities()
      --     vim.lsp.config("lua_ls", {
      --       capabilities = capabilities,
      --       settings = {
      --         Lua = {
      --           workspace = { checkThirdParty = false },
      --         },
      --       },
      --     })
      --   end,
      -- },
      automatic_enable = true,
    },
  },

  -- ── Core LSP configuration ───────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
}
