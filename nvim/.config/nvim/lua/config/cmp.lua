local M = {}

vim.o.completeopt = "menu,menuone,noselect"
local mapping = require("cmp.config.mapping")
local compare = require "cmp.config.compare"
local lspkind = require "lspkind"


local source_mapping = {
  nvim_lsp_signature_help = "[Sig]",
  nvim_lsp = "[Lsp]",
  luasnip = "[Snip]",
  buffer = "[Buffer]",
  nvim_lua = "[Lua]",
  treesitter = "[Tree]",
  path = "[Path]",
  rg = "[Rg]",
  emoji = "[emoji]",
  -- cmp_tabnine = "[TNine]",
}

function M.setup()

  local luasnip = require "luasnip"
  local cmp = require "cmp"
local select_opts = {behavior = cmp.SelectBehavior.Select}

  cmp.setup {
    completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
    sorting = {
      priority_weight = 2,
      comparators = {
        -- require "cmp_tabnine.compare",
        compare.score,
        compare.recently_used,
        compare.offset,
        compare.exact,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Up>"] = mapping.select_prev_item(select_opts),
      ["<Down>"] = mapping.select_next_item(select_opts),

      ["<C-p>"] = mapping.select_prev_item(select_opts),
      ["<C-n>"] = mapping.select_next_item(select_opts),

      ["<C-u>"] = mapping.scroll_docs(-4),
      ["<C-f>"] = mapping.scroll_docs(4),

      ["<C-e>"] = mapping.abort(),
      ["<CR>"] = mapping.confirm { select = false },

      ["<C-d>"] = mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-b>"] = mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<Tab>"] = mapping(function(fallback)
        local col = vim.fn.col "." - 1

        if cmp.visible() then
          cmp.select_next_item(select_opts)
        elseif col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
          fallback()
        else
          cmp.complete()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = "text_symbol",
        maxwidth = 40,

        before = function(entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind]

          local menu = source_mapping[entry.source.name]
          vim_item.menu = menu
          return vim_item
        end,
      },
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp", max_item_count = 15 },
      { name = "nvim_lsp_signature_help" },
      -- { name = "cmp_tabnine" },
      { name = "treesitter", max_item_count = 5 },
      { name = "rg", max_item_count = 2 },
      { name = "buffer", max_item_count = 2 },
      { name = "nvim_lua" },
      { name = "path" },
      -- { name = "spell" },
      { name = "emoji" },
      -- { name = "calc" },
    },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
      },
    },
  }

  -- Use buffer source for `/`
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  -- Auto pairs
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

return M
