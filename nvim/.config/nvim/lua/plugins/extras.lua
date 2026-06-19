-- =============================================================================
-- plugins/extras.lua — Small utility plugins
-- =============================================================================
return {
  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
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
  -- ── Terminal  ──────────────────────────────────────────────────────────────
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- Ensures you use stable releases
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm" },
    },
    config = function()
      require("toggleterm").setup({
        -- Use <C-\> as the global shortcut to toggle the terminal
        open_mapping = [[<c-\>]],

        -- Terminal behavior and styling
        size = 20, -- Height for horizontal, width for vertical splits
        hide_numbers = true, -- Hide line numbers in terminal buffers
        shade_terminals = true, -- Dim background contrast relative to main editor
        shading_factor = 2, -- Degree of background dimming (1-3)
        start_in_insert = true, -- Always enter insert mode immediately when opened
        insert_mappings = true, -- open_mapping applies in insert mode
        terminal_mappings = true, -- open_mapping applies in terminal mode
        persist_size = true, -- Remember terminal window size changes
        direction = "horizontal", -- Default layout: 'horizontal', 'vertical', 'tab', 'float'
        close_on_exit = true, -- Automatically close window when shell process exits
        shell = vim.o.shell, -- Use the default user shell

        -- Floating terminal appearance (used if direction = 'float')
        float_opts = {
          border = "curved", -- Options: 'single', 'double', 'shadow', 'curved'
          winblend = 3, -- Semi-transparent float window background
        },
      })

      -- Handle terminal-specific keymaps securely
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Easy escape back to normal mode inside the terminal
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

        -- Seamless window navigation out of the terminal split
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- Apply mappings only when a terminal opens
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
