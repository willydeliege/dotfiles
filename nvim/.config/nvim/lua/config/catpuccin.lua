local M = {}

function M.setup()
  require("catppuccin").setup {
    flavour = "mocha", -- mocha, macchiato, frappe, latte
    color_overrides = {
      mocha = {
        base = "#000000",
      },
    },
    styles = {
      comments = {},
      conditionnals = {},
    },
    integrations = {
      aerial = true,
      cmp = true,
      fidget = true,
      gitsigns = true,
      illuminate = true,
      leap = true,
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      neogit = true,
      neotest = false,
      neotree = true,
      noice = true,
      notify = true,
      overseer = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbow = true,
      which_key = true,

      -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
      dap = {
        enabled = true,
        enable_ui = true,
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      navic = {
        enabled = true,
        custom_bg = "NONE",
      },
    },
  }
  vim.api.nvim_command "colorscheme catppuccin-mocha"
end

return M
