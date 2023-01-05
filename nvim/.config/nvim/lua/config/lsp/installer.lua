local M = {}

function M.setup(servers, server_options)
  local lspconfig = require "lspconfig"
  local icons = require "config.icons"

  require("mason").setup {
    ui = {
      border = "single",
      icons = {
        package_installed = icons.lsp.server_installed,
        package_pending = icons.lsp.server_pending,
        package_uninstalled = icons.lsp.server_uninstalled,
      },
    },
  }

  require("mason-tool-installer").setup {
    ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "prettierd" },
    auto_update = true,
    run_on_start = true,
  }

  require("mason-lspconfig").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  }
  -- local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  -- Package installation folder

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend("force", server_options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
    ["jdtls"] = function()
      -- print "jdtls is handled by nvim-jdtls"
    end,
    ["sumneko_lua"] = function()
      local opts = vim.tbl_deep_extend("force", server_options, servers["sumneko_lua"] or {})
      require("neodev").setup {}
      lspconfig.sumneko_lua.setup(opts)
    end,
    ["lemminx"] = function ()
      lspconfig.lemminx.setup({
        cmd ={"java","-cp",  "/home/willefi/.classpath/lemminx-maven-0.7.0-SNAPSHOT-zip-with-dependencies.zip", "-jar", "/home/willefi/.classpath/org.eclipse.lemminx-uber.jar"}
      })
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", server_options, servers["tsserver"] or {})
      require("typescript").setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    end,
  }
end

return M
