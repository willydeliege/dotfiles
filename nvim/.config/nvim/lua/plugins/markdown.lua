---@diagnostic disable: missing-fields
return {
  {
    "obsidian-nvim/obsidian.nvim",
    cmd = { "Obsidian" },
    keys = {
      { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian find files" },
      { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian backlinks" },
      { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Obsidian links" },
      { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian new note" },
      { "<leader>oT", "<cmd>Obsidian tags<cr>", desc = "Obsidian tags" },
      { "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
      { "<leader>ox", "capture", desc = "Obsidian capture" },
    },
    dependencies = { "ibhagwan/fzf-lua" },
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
        name = "fzf-lua",
      },
      -- note_id_func =
      checkbox = {
        enabled = true,
        create_new = false,
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

      local capture = function()
        -- On récupère la note du jour via Obsidian.nvim
        local today_note = require("obsidian.daily").today()

        -- Utilisation de vim.fn.input (synchrone, insensible aux conflits d'UI)
        local status, input_text = pcall(vim.fn.input, "Capture : ")

        -- Si l'utilisateur valide avec du texte
        if status and input_text and input_text ~= "" then
          -- Insertion sécurisée dans Obsidian
          today_note:insert_text("- " .. input_text, { placement = "bot", section = nil })
          print("Texte ajouté à la note du jour !")
        else
          print("Saisie annulée ou vide.")
        end
      end

      vim.keymap.set("n", "<leader>ox", capture, { desc = "Capture in today" })
    end,
  },
  -- For `plugins/markview.lua` users.
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      markdown = {
        enable = true,
        list_items = {
          marker_minus = {
            add_padding = false,
          },
        },
      },
    },
  },
}
