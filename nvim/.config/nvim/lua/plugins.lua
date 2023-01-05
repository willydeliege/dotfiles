local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = "plugins.lua", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require("config.notify").setup()
      end,
      disable = false,
    }
    -- Colorscheme
    use {
      "Mofiqul/dracula.nvim",
      config = function()
        require("config.theme").setup()
      end,
    }
    use { "khaveesh/vim-fish-syntax", ft = { "fish" } }
    use { "ericpruitt/tmux.vim", ft = { "tmux" } }
    use {
      "nvchad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup {}
      end,
    }
    use {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
    }
    use {
      "ziontee113/color-picker.nvim",
      cmd = { "PickColor", "PickColorInsert" },
      config = function()
        require "color-picker"
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
      disable = true,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use { "tpope/vim-fugitive" }
    use {
      "akinsho/git-conflict.nvim",
      cmd = {
        "GitConflictChooseTheirs",
        "GitConflictChooseOurs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
      },
      config = function()
        require("git-conflict").setup()
      end,
      disable = true,
    }
    use { "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      -- keys = { [[<leader>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("config.comment").setup()
      end,
      disable = false,
    }

    -- Buffer
    use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }
    -- IDE
    use {
      "max397574/better-escape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          mapping = { "jk", "kj", "jj", "kk" },
          timeout = vim.o.timeoutlen,
          keys = "<ESC>",
        }
      end,
    }
    use {
      "karb94/neoscroll.nvim",
      event = "BufReadPre",
      config = function()
        require("config.neoscroll").setup()
      end,
      disable = false,
    }
    -- Code documentation
    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen",
      disable = false,
    }
    --easy motions
    use { "ggandor/lightspeed.nvim" }
    use {
      "gukz/ftFT.nvim",
      event = "BufReadPre",
      -- This will turn on all functions, if you don't like some of them, add more config to disable/change them
      config = function()
        require("ftFT").setup()
      end,
    }
    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufReadPre",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      commit = "a2d7e78b0714a0dc066416100b7398d3f0941c23",
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        -- {
        --   "lewis6991/spellsitter.nvim",
        --   config = function()
        --     require("spellsitter").setup()
        --   end,
        -- },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = false },
        {
          "m-demare/hlargs.nvim",
          config = function()
            require("config.hlargs").setup()
          end,
          disable = true,
        },
      },
    }
    use {
      "kevinhwang91/nvim-hlslens",
      event = "BufReadPre",
      config = function()
        require("config.hlslens").setup()
      end,
    }
    use {
      "nvim-telescope/telescope.nvim",
      disable = false,
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      keys = { "<leader>f", "<leader>p", "<leader>z" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "project.nvim",
        -- "vim-rooter",
        "trouble.nvim",
        "telescope-dap.nvim",
        "telescope-frecency.nvim",
        "nvim-neoclip.lua",
        "telescope-smart-history.nvim",
        "telescope-zoxide",
        "aerial.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("config.project").setup()
          end,
        },
        "nvim-telescope/telescope-dap.nvim",
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
            -- config = function()
            --   require("neoclip").setup()
            -- end,
          },
        },
        "nvim-telescope/telescope-smart-history.nvim",
        "jvgrootveld/telescope-zoxide",
        "nvim-telescope/telescope-symbols.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
      },
    }

    -- Packer
    use {
      "jackMort/ChatGPT.nvim",
      event = "BufReadPre",
      config = function()
        require("chatgpt").setup {
          -- optional configuration
        }
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    }
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

    use {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "Neotree",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("config.neotree").setup()
      end,
      disable = false,
    }
    use {
      "s1n7ax/nvim-window-picker",
      tag = "v1.*",
      config = function()
        require("window-picker").setup()
      end,
    }
    -- tmux navigation
    use {
      "alexghergh/nvim-tmux-navigation",
      config = function()
        require("config.tmux").setup()
      end,
    }
    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = false,
    }
    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip", "lspkind-nvim" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        "onsails/lspkind-nvim",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
          disable = false,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    use {
      event = "BufReadPre",
      "joechrisellis/lsp-format-modifications.nvim",
    }
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        -- "nvim-lsp-installer",
        "mason.nvim",
        "mason-lspconfig.nvim",
        "mason-tool-installer.nvim",
        "cmp-nvim-lsp",
        "neodev.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
        "typescript.nvim",
        "nvim-navic",
        -- "goto-preview",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        { "jose-elias-alvarez/null-ls.nvim" },
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {
              window = {
                blend = 0,
              },
            }
          end,
        },
        "b0o/schemastore.nvim",
        "jose-elias-alvarez/typescript.nvim",
        {
          "SmiteshP/nvim-navic",
          -- "alpha2phi/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
        {
          "lvimuser/lsp-inlayhints.nvim",
        },
        {
          "theHamsta/nvim-semantic-tokens",
          config = function()
            require("config.semantictokens").setup()
          end,
          disable = true,
        },
      },
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "glepnir/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").init_lsp_saga()
      end,
    }

    -- Go

    -- Java
    use {
      "mfussenegger/nvim-jdtls",
      ft = { "java" },
      requires = {
        "https://gitlab.com/schrieveslaach/nvim-jdtls-bundles",
        run = "./install-bundles.py",
        ft = { "java" },
      },
    }
    use {
      "ThePrimeagen/refactoring.nvim",
    }
    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      -- event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
      requires = {
        -- "alpha2phi/DAPInstall.nvim",
        -- { "Pocco81/dap-buddy.nvim", branch = "dev" },
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go", module = "dap-go" },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }

    use { "diepm/vim-rest-console", ft = { "rest" }, disable = false }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }

    -- Session
    use {
      "rmagatti/auto-session",
      opt = true,
      cmd = { "SaveSession", "RestoreSession" },
      requires = { "rmagatti/session-lens" },
      wants = { "telescope.nvim", "session-lens" },
      config = function()
        require("bad_practices").setup()
      end,
      disable = false,
    }

    -- Todo
    use {
      "folke/todo-comments.nvim",
      config = function()
        require("config.todocomments").setup()
      end,
      cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
    }

    -- Diffview
    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    }

    use {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup()
      end,
      module = { "aerial" },
      cmd = { "AerialToggle" },
    }

    -- Task runner
    use {
      "stevearc/overseer.nvim",
      opt = true,
      cmd = {
        "OverseerToggle",
        "OverseerOpen",
        "OverseerRun",
        "OverseerBuild",
        "OverseerClose",
        "OverseerLoadBundle",
        "OverseerSaveBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerQuickAction",
        "OverseerTaskAction",
      },
      config = function()
        require("overseer").setup()
      end,
    }
    -- Database
    use {
      "tpope/vim-dadbod",
      opt = true,
      requires = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
        --[[ "abenz1267/nvim-databasehelper", ]]
      },
      --[[ wants = { "nvim-databasehelper" }, ]]
      --[[ wants = { "nvim-databasehelper" }, ]]
      config = function()
        require("config.dadbod").setup()
      end,
      cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }
    use {
      "nanotee/sqls.nvim",
      module = { "sqls" },
      cmd = {
        "SqlsExecuteQuery",
        "SqlsExecuteQueryVertical",
        "SqlsShowDatabases",
        "SqlsShowSchemas",
        "SqlsShowConnections",
        "SqlsSwitchDatabase",
        "SqlsSwitchConnection",
      },
    }

    use { "ThePrimeagen/vim-be-good" }
    use { "neomutt/neomutt.vim" }
    -- Incremaent and decrement booleans, days, numbers....
    use {
      "nat-418/boole.nvim",
      envent = "BufReadPre",
      config = function()
        require("config.boole").setup()
      end,
    }
    -- plantuml
    use { "aklt/plantuml-syntax", ft = { "plantuml" } }
    -- Markdown

    use {
      "andrewferrier/wrapping.nvim",
      config = function()
        require("wrapping").setup {
          softener = { markdown = 1.3 },
        }
      end,
      event = "BufReadPre",
      disable = false,
    }
    use {
      "uga-rosa/translate.nvim",
      ft = "markdown",
      config = function()
        require("translate").setup {}
      end,
    }
    use { "willydeliege/markdowntasks", event = "VimEnter" }
    use { "preservim/tagbar", ft= "markdown" }
    use { "powerman/vim-plugin-AnsiEsc", ft = "markdown" }
    use  {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        require "config.mkdnflow"
      end,
      ft = "markdown",
      event = "BufRead",
    }
    use {
      "mickael-menu/zk-nvim",
      ft = "markdown",
      event = "VimEnter",
      config = function()
        require("zk").setup {
          picker = "telescope",
        }
      end,
    }
    use { "godlygeek/tabular", ft = "markdown" }
    use { "ellisonleao/glow.nvim" }
    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
