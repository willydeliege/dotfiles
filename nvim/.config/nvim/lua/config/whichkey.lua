local M = {}

local whichkey = require "which-key"
local picker = require "window-picker"
local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil -- File search

  keymap_f = {
    name = "Find",
    e = { "<cmd>Neotree toggle<cr>", "NeoTree" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
    w = { "<cmd>lua require('utils.finder').find_pkm()<cr>", "PKM" },
  }
  local keymap = {
    ["e"] = { "<cmd>Neotree toggle reveal_force_cwd<cr>", "Explorer" },
    ["n"] = { ":e!<cr>", "Reload buffer" },
    ["i"] = { ":edit " .. os.getenv("HOME")  .. "/willydeliege/index.md<CR><bar><cmd>e!<cr>", "PKM Index" },

    ["<tab>"] = {
      name = "Tabs",
      ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },
      n = { "<cmd>tabnext<CR>", "Next" },
      c = { "<cmd>tabclose<CR>", "Close" },
      p = { "<cmd>tabprevious<CR>", "Previous" },
      f = { "<cmd>tabfirst<CR>", "First" },
      l = { "<cmd>tablast<CR>", "Last" },
    },
    ["w"] = {
      name = "+windows",
      ["w"] = { "<C-W>p", "other-window" },
      ["d"] = { "<C-W>c", "delete-window" },
      ["-"] = { "<C-W>s", "split-window-below" },
      ["|"] = { "<C-W>v", "split-window-right" },
      ["2"] = { "<C-W>v", "layout-double-columns" },
      ["h"] = { "<C-W>h", "window-left" },
      ["j"] = { "<C-W>j", "window-below" },
      ["l"] = { "<C-W>l", "window-right" },
      ["k"] = { "<C-W>k", "window-up" },
      ["H"] = { "<C-W>5<", "expand-window-left" },
      ["J"] = { ":resize +5", "expand-window-below" },
      ["L"] = { "<C-W>5>", "expand-window-right" },
      ["K"] = { ":resize -5", "expand-window-up" },
      ["="] = { "<C-W>=", "balance-window" },
      ["s"] = { "<C-W>s", "split-window-below" },
      ["v"] = { "<C-W>v", "split-window-right" },
      ["p"] = {
        function()
          local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        "Pick a window"
      },
      ["P"] = {
        function ()
          local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_win_close(picked_window_id,true)
        end,
        "Pick and close window"
      }
    },
    b = {
      name = "Buffer",
      c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
      f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
      D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
      ["("] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
      [")"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      l = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers list" },
    },
    q = {
      name = "Quit/session",
      q = { "<cmd>qa<cr>", "Quit" },
      ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
      s = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
      h = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
    },
    s = {
      name = "Search",
      g = { "<cmd>Telescope live_grep<cr>", "Grep" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols {
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          }
        end,
        "Goto Symbol",
      },
      m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
      c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
      k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "Keymaps" },
      p = { "<cmd>lua require'telescope'.extensions.projects.projects{}<cr>", "Projects" },
    },
    ["h"] = {
      name = "Help",
      t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
      c = { "<cmd>:Telescope commands<cr>", "Commands" },
      h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
      m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
      k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
      s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
      f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
      o = { "<cmd>:Telescope vim_options<cr>", "Options" },
      a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
      p = {
        name = "Packer",
        p = { "<cmd>PackerSync<cr>", "Sync" },
        s = { "<cmd>PackerStatus<cr>", "Status" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        c = { "<cmd>PackerCompile<cr>", "Compile" },
      },
    },

    d = {
      name = "Debug",
    },

    -- Database
    D = {
      name = "Database",
      u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
      f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
      r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
      q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    },

    f = keymap_f,

    z = {
      name = "Zettelkasten",
      l = { "<cmd>ZkLinks<cr>", "Links" },
      b = { "<cmd>ZkBacklinks<cr>", "BackLink" },
      n = { "<cmd>ZkNotes<cr>", "List notes" },
      d = {
        name = "Diary",
        d = { "<cmd>ZkNew { dir = 'diary' }<cr>", "Today" },
        y = { "<cmd>ZkNew { dir = 'diary', date='yesterday' }<cr>", "Yesterday" },
        t = { "<cmd>ZkNew { dir = 'diary', date='tomorrow' }<cr>", "Tomorrow" },
      }
    },

    o = {
      name = "Overseer",
      C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
      a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
      b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
      c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
      d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
      l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
      o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
      q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
      r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
      s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
      t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
    },

    t = {

      name = "Tasks",
      w = { "<cmd>lua require('utils.term').taskwarrior_tui_toggle()<cr>", "Taskwarriot TUI" },
    },

    Z = {
      name = "System",
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      e = { "!!$SHELL<CR>", "Execute line" },
    },
    g = {
      name = "Git",
      c = { "<Cmd>Telescope git_commits<CR>", "commits" },
      b = { "<Cmd>Telescope git_branches<CR>", "branches" },
      s = { "<Cmd>Telescope git_status<CR>", "status" },
      d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
      z = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
      h = { name = "Hunk" },
    },
  }
  whichkey.register(keymap, opts)
end

local function visual_keymap()
  local keymap = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },

    r = {
      name = "Refactor",
      f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
      F = {
        [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
        "Extract Function to File",
      },
      v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
      i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
      r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
      d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
end


function M.setup()
  normal_keymap()
  visual_keymap()
end

return M
