local M = {}

local vim = vim
local whichkey = require "which-key"
local next = next

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
    f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
    d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
    b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
    m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
    o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
    c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "Keymaps" },
    r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
    w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    p = { "<cmd>lua require'telescope'.extensions.projects.projects()<cr>", "Projects" },
    e = { "<cmd>Neotree toggle reveal_force_cwd<cr>", "Explorer" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["e"] = { "<cmd>Neotree toggle reveal_force_cwd<cr>", "Explorer" },
    ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
    ["n"] = { ":e!<cr>", "Reload buffer"},
    ["i"] = { ":edit " .. os.getenv("HOME") .."/willydeliege/index.md<CR><bar><cmd>e!<cr>", "PKM Index"},

    b = {
      name = "Buffer",
      c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
      f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
      D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    },

    c = {
      name = "Code",
      g = { "<cmd>Neogen func<Cr>", "Func Doc" },
      G = { "<cmd>Neogen class<Cr>", "Class Doc" },
      d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
      o = { "<cmd>Telescope aerial<Cr>", "Outline" },
      T = { "<cmd>TodoTelescope<Cr>", "TODO" },
      x = {
        name = "Swap Next",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      X = {
        name = "Swap Previous",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      -- f = "Select Outer Function",
      -- F = "Select Outer Class",
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

    ["0"] = { "<Cmd>2ToggleTerm<Cr>", "ToggleTerm 2" },

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
	z = {
		name = "Zettelkasten",
		n = { "<cmd>ZkNotes {sort = {'modified'} }<cr>", "List notes" },
	},



    s = {
      name = "Search",
      o = { [[ <Esc><Cmd>lua require('spectre').open()<CR>]], "Open" },
      c = { [[ <Esc><Cmd>lua require('utils.cht').cht_input()<CR>]], "cht.sh" },
      s = { [[ <Esc><Cmd>lua require('utils.term').so()<CR>]], "Stack Overflow" },
    },

    x = {
      name = "External",
      d = { "<cmd>lua require('utils.term').docker_client_toggle()<CR>", "Docker" },
      p = { "<cmd>lua require('utils.term').project_info_toggle()<CR>", "Project Info" },
      s = { "<cmd>lua require('utils.term').system_info_toggle()<CR>", "System Info" },
      c = { "<cmd>lua require('utils.term').cht()<CR>", "Cheatsheet" },
      i = { "<cmd>lua require('utils.term').interactive_cheatsheet_toggle()<CR>", "Interactive Cheatsheet" },
    },
    t = {

      name = "Tasks",
      w = { "<cmd>lua require('utils.term').taskwarrior_tui_toggle()<cr>", "Taskwarriot TUI" },
    },

    Z = {
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
      e = { "!!$SHELL<CR>", "Execute line" },
      W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
      w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
      z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    },

    g = {
      name = "Git",
      b = { "<cmd>GitBlameToggle<CR>", "Blame" },
      c = { "<cmd>lua require('utils.term').git_commit_toggle()<CR>", "Conventional Commits" },
      p = { "<cmd>Git push<CR>", "Push" },
      s = { "<cmd>Neogit<CR>", "Status - Neogit" },
      S = { "<cmd>Git<CR>", "Status - Fugitive" },
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
      g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
      z = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
      h = { name = "Hunk" },
      t = { name = "Toggle" },
      x = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Switch Branch" },
      -- g = {
      --   name = "+Github",
      --   c = {
      --     name = "+Commits",
      --     c = { "<cmd>GHCloseCommit<cr>", "Close" },
      --     e = { "<cmd>GHExpandCommit<cr>", "Expand" },
      --     o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
      --     p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
      --     z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      --   },
      --   i = {
      --     name = "+Issues",
      --     p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      --   },
      --   l = {
      --     name = "+Litee",
      --     t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      --   },
      --   r = {
      --     name = "+Review",
      --     b = { "<cmd>GHStartReview<cr>", "Begin" },
      --     c = { "<cmd>GHCloseReview<cr>", "Close" },
      --     d = { "<cmd>GHDeleteReview<cr>", "Delete" },
      --     e = { "<cmd>GHExpandReview<cr>", "Expand" },
      --     s = { "<cmd>GHSubmitReview<cr>", "Submit" },
      --     z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      --   },
      --   p = {
      --     name = "+Pull Request",
      --     c = { "<cmd>GHClosePR<cr>", "Close" },
      --     d = { "<cmd>GHPRDetails<cr>", "Details" },
      --     e = { "<cmd>GHExpandPR<cr>", "Expand" },
      --     o = { "<cmd>GHOpenPR<cr>", "Open" },
      --     p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
      --     r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
      --     t = { "<cmd>GHOpenToPR<cr>", "Open To" },
      --     z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      --   },
      --   t = {
      --     name = "+Threads",
      --     c = { "<cmd>GHCreateThread<cr>", "Create" },
      --     n = { "<cmd>GHNextThread<cr>", "Next" },
      --     t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      --   },
      -- },
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

local function code_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(CodeRunner)
    end,
  })

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand "%:p:t"
    local keymap_c = {} -- normal key map
    local keymap_c_v = {} -- visual key map

    if ft == "python" then
      keymap_c = {
        name = "Code",
        -- r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
        -- r = { "<cmd>update<CR><cmd>TermExec cmd='python3 %'<cr>", "Run" },
        i = { "<cmd>cexpr system('refurb --quiet ' . shellescape(expand('%'))) | copen<cr>", "Inspect" },
        r = {
          "<cmd>update<cr><cmd>lua require('utils.term').open_term([[python3 ]] .. vim.fn.shellescape(vim.fn.getreg('%'), 1), {direction = 'float'})<cr>",
          "Run",
        },
        m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
      }
    elseif ft == "lua" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>luafile %<cr>", "Run" },
      }
    elseif ft == "rust" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
        D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
        h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
        R = { "<cmd>RustRunnables<cr>", "Runnables" },
      }
    elseif ft == "go" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>GoRun<cr>", "Run" },
      }
    elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
        i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
        F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
        u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
        R = { "<cmd>lua require('config.neotest').javascript_runner()<cr>", "Choose Test Runner" },
        -- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
        -- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
      }
    elseif ft == "java" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
        v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
        t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
        n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
      }
      keymap_c_v = {
        name = "Code",
        v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
      }
    end

    if fname == "package.json" then
      keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
      keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
      -- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
      -- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
    end

    if fname == "Cargo.toml" then
      keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
    end

    if next(keymap_c) ~= nil then
      local k = { c = keymap_c }
      local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
    end

    if next(keymap_c_v) ~= nil then
      local k = { c = keymap_c_v }
      local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
    end
  end
end

function M.setup()
  normal_keymap()
  visual_keymap()
  code_keymap()
end

return M
