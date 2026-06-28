return {
  {
    "obsidian-nvim/obsidian.nvim",
    cmd = { "Obsidian", "ObsidianCapture" },
    keys = {
      { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian find files" },
      { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
      { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Obsidian links" },
      { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian new note" },
      { "<leader>oT", "<cmd>Obsidian tags<cr>", desc = "Obsidian tags" },
      { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
      { "<leader>ox", "<cmd>ObsidianCapture<cr>", desc = "Obsidian capture" },
    },
    opts = {
      legacy_commands = false, -- this will be removed in 4.0.0
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/MyPkm/",
        },
      },
      ui = { enable = false },
      picker = {
        name = "snacks.picker",
      },
      -- note_id_func =
      checkbox = {
        create_new = true,
        order = { " ", "x" },
      },
      daily_notes = {
        folder = "Daily",
      },
    },
    config = function(_, opts)
      local note_name = { note_id_func = require("obsidian.builtin").title_id }
      local new_opts = vim.tbl_extend("force", opts, note_name)
      require("obsidian").setup(new_opts)

      vim.api.nvim_create_user_command("ObsidianCapture", function()
        -- On récupère la note du jour via Obsidian.nvim
        local today_note = require("obsidian.daily").today()

        -- Utilisation de vim.fn.input (synchrone, insensible aux conflits d'UI)
        local status, input_text = pcall(vim.fn.input, "Capture : ")

        -- Si l'utilisateur valide avec du texte
        if status and input_text and input_text ~= "" then
          -- Insertion sécurisée dans Obsidian
          today_note:insert_text(
            "- " .. input_text,
            { placement = "bot", on_section_missing = "create", section = { level = 2, header = "Inbox" } }
          )
          vim.notify("Added to today's note")
        else
          vim.notify("Capture canceled or empty")
        end
      end, {})
    end,
  },
  -- For `plugins/markview.lua` users.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        position = "overlay",
        border = true,
      },
    },
  },
}
