-- =============================================================================
-- plugins/formatting.lua — conform.nvim (code formatter)
-- =============================================================================
-- conform.nvim runs formatters asynchronously on save (or on demand).
-- Formatters are installed separately (e.g. via Mason or your system package
-- manager); conform only dispatches to them.
--
-- Formatters configured here:
--   lua       — stylua
--   markdown  — prettier (or prettierd for speed)
--   bash / sh — shfmt
--   json      — prettier
--   yaml      — prettier
-- =============================================================================

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "Format" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer / selection",
      },
    },
    opts = {
      -- -----------------------------------------------------------------------
      -- Formatter chains per filetype
      -- The first formatter in the list that is available will be used.
      -- Use a sub-table { … } to run formatters sequentially.
      -- -----------------------------------------------------------------------
      formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        bash = { "shfmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        toml = { "taplo" },
        -- Fallback: for any filetype not listed, try the LSP formatter
        ["*"] = { "injected" }, -- format embedded code blocks
      },

      -- -----------------------------------------------------------------------
      -- Format on save
      -- -----------------------------------------------------------------------
      format_on_save = {
        timeout_ms = 10000, -- abort if formatting takes longer than 10000 ms
        lsp_fallback = true, -- fall back to LSP formatting if no formatter found
      },

      -- -----------------------------------------------------------------------
      -- Formatter-specific overrides
      -- -----------------------------------------------------------------------
      formatters = {
        shfmt = {
          -- -i 2: 2-space indent  -ci: indent case labels  -bn: binary ops on new line
          prepend_args = { "-i", "2", "-ci", "-bn" },
        },
        stylua = {
          -- Respect the project-level .stylua.toml if present; otherwise these
          -- flags produce sane defaults consistent with common Lua projects.
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },

      -- -----------------------------------------------------------------------
      -- Notification: show a brief message when formatting fails
      -- -----------------------------------------------------------------------
      notify_on_error = true,
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Expose a `:Format` user command as a convenience
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, #end_line[1] },
          }
        end
        require("conform").format({
          async = true,
          lsp_fallback = true,
          range = range,
        })
      end, { range = true, desc = "Format buffer or selection with conform.nvim" })
    end,
  },
}
