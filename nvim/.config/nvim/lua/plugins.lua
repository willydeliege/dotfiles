---@diagnostic disable: missing-parameter
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Performance
pcall(require, "impatient") -- Call impatient plugin before all others to improve performance. Keep this line here.


-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)

    ---------------------
    -- Package Manager --
    ---------------------
    use "wbthomason/packer.nvim" -- Packer manage itself

    ----------------------
    -- Dependencies --
    ----------------------
    -- Improve startup time (source: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236)
    use "lewis6991/impatient.nvim"
    use "nathom/filetype.nvim"
    use "nvim-lua/plenary.nvim"
    use 'kyazdani42/nvim-web-devicons'
    use "nvim-lua/popup.nvim"


    ----------------------
    -- General --
    ----------------------

    -- Key Navigator
    use "folke/which-key.nvim"

    -- Measure nvim startup time
    use "dstein64/vim-startuptime"

    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup {
                mapping = { "jk", "jj", "kj", "kk" }, -- a table with mappings to use
            }
        end,
    }
    -- show identations
    use { "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.indent-blank-lines")
        end
    }

    ----------------------------
    -- Notifications
    ----------------------------

    use "rcarriga/nvim-notify"

    -----------------------------------------------
    -- Themes, Icons, Tree, Statusbar, Bufferbar --
    -----------------------------------------------

    -- Colorschemes
    use "LunarVim/Colorschemes"
    use { 'lalitmee/cobalt2.nvim', requires = 'tjdevries/colorbuddy.nvim' }
    use {"adisen99/codeschool.nvim", requires = {"rktjmp/lush.nvim"}}
    -- Buffer (Tab) line
    use "akinsho/bufferline.nvim" --
    use "kazhala/close-buffers.nvim"
    -- Status Line
    use 'nvim-lualine/lualine.nvim'

    --Dashboard
    use "goolord/alpha-nvim"

    --------------------------------------
    -- File Navigation and Fuzzy Search --
    --------------------------------------

    -- Nvim Tree
    use "kyazdani42/nvim-tree.lua"


    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                's1n7ax/nvim-window-picker',
                tag = "v1.*",
                config = function()
                    require("plugins.window-picker")
                end,
            }
        },
        config = function()
            require("plugins.neotree")
        end
    }
    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Find projects
    use "ahmedkhalf/project.nvim"
  
     -- session management
    use { "stevearc/dressing.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim" }
    use { "Shatur/neovim-session-manager",
        config = function ()
            require("plugins.session-manager")
        end
    }
    -- show cursor 
    use { "rainbowhxch/beacon.nvim",
        config = function()
            require("plugins.beacon")
        end
    }

    -- --------------------------------------
    -- Autocompletion --
    --------------------------------------
    use "hrsh7th/nvim-cmp" -- Completion (cmp) plugin
    use "hrsh7th/cmp-buffer" -- Cmp source for buffer words
    use "hrsh7th/cmp-path" -- Cmp source for path
    use "hrsh7th/cmp-nvim-lsp" -- Cmp source for LSP client
    use "hrsh7th/cmp-nvim-lua" -- Cmp source for nvim lua
    use "saadparwaiz1/cmp_luasnip" -- Luasnip completion source

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    --------------------------------------
    -- LSP --
    --------------------------------------
    --  Copilot
    use "zbirenbaum/copilot.lua" -- Github Copilot in lua

    -- LSP
    use "neovim/nvim-lspconfig" -- Enable native LSP
    -- use "williamboman/nvim-lsp-installer"
    use { "williamboman/mason.nvim",
            config = function ()
                require ("mason").setup{}
            end
    }
    use { "williamboman/mason-lspconfig.nvim",
         config = function ()
            require("mason-lspconfig").setup({
                ensure_installed = { "sumneko_lua" },
                automatic_installation = true,
            })
            require'lspconfig'.sumneko_lua.setup{}
         end
    }
    use "antoinemadec/FixCursorHold.nvim" -- Fix lsp doc highlight
    use "tamago324/nlsp-settings.nvim" -- Configure LSP settings with json
    use "folke/lua-dev.nvim"
    -- Java
    use { "mfussenegger/nvim-jdtls" }
    use { "https://gitlab.com/schrieveslaach/nvim-jdtls-bundles",
        run = "./install-bundles.py"
    }
    use { "j-hui/fidget.nvim",
        config = function()
        require("fidget").setup()
    end
    }
    --  Formatters
    use "jose-elias-alvarez/null-ls.nvim" -- Inject LSP diagnostics, code actions, formatters ...


    --LSP diagnostics
    use {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    }


    --------------------------------------
    -- Features --
    --------------------------------------

    --Terminal
    use "akinsho/toggleterm.nvim" -- Cannot lazyload for some reason.

    --Show colors
    use { "norcalli/nvim-colorizer.lua", event = "BufRead" }

    --Replace with sed cmd
    use { "windwp/nvim-spectre", event = "BufRead" }

    --Zen Mode
    use { "folke/zen-mode.nvim", cmd = "ZenMode" }

    --Class outline
    use { "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" }

    --Testing
    use { "vim-test/vim-test",
        cmd = { "TestFile", "TestNearest", "TestSuite", "TestVisit" },
    }


    --------------------------------------
    -- Editing --
    --------------------------------------

    --Commenting
    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use { "unblevable/quick-scope" }
    --------------------------------------
    -- File type specific --
    --------------------------------------

    --Markdown
    use { 'godlygeek/tabular', ft = "markdown" }
    use { 'preservim/vim-markdown', ft = "markdown" }
    -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
    use { 'dkarter/bullets.vim', ft = "markdown" }

    --Csv
    use { "mechatroner/rainbow_csv", ft = "csv" }

    --------------------------------------
    -- Git --
    --------------------------------------
    use {
        'lewis6991/gitsigns.nvim',
        event = "BufRead",
        config = function()
            require('gitsigns').setup()
        end
    }
    use { "f-person/git-blame.nvim", cmd = "GitBlameToggle" }
    use { "https://github.com/rhysd/conflict-marker.vim", event = "BufRead" }


    --------------------------------------
    -- DAP --
    --------------------------------------
    use { "mfussenegger/nvim-dap", event = "BufRead" }
    -- use "theHamsta/nvim-dap-virtual-text"
    -- use "rcarriga/nvim-dap-ui"
    use { "Pocco81/DAPInstall.nvim", event = "BufRead" }


    -----------------------------------
    -- Treesitter --
    -----------------------------------

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- Syntax highlighting
    use { "windwp/nvim-ts-autotag" } -- Auto close tags
    use { "windwp/nvim-autopairs" } -- Autoclose quotes, parentheses etc.


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
