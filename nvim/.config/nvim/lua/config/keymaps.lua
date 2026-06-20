-- =============================================================================
-- config/keymaps.lua — Plugin-independent key mappings
-- =============================================================================
-- Conventions:
--   <leader>  = Space (set below)
--   Mappings that require a plugin live in their respective plugin spec file.
-- =============================================================================

vim.g.mapleader = " " -- Space as the leader key
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── General ───────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader><CR>", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file exécutable" })

local file_commands = {
  sh = "bash",
  bash = "bash",
  python = "python3",
  javascript = "node",
  typescript = "ts-node",
  lua = "lua",
  perl = "perl",
  ruby = "ruby",
}

local function execute_current_file()
  -- Sauvegarde automatique avant l'exécution
  vim.cmd("silent! write")

  local ft = vim.bo.filetype
  local cmd = file_commands[ft]

  if cmd then
    vim.cmd(string.format("!%s %%", cmd))
  else
    -- Si non listé, tente l'exécution directe si le fichier est exécutable
    vim.cmd("!./%")
  end
end

vim.keymap.set("n", "<leader>fX", execute_current_file, { desc = "Execute script" })
-- ── Better movement ───────────────────────────────────────────────────────────
-- Center screen after jumps
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- ── Window resizing ───────────────────────────────────────────────────────────
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ── Project management with tmux
map("n", "<leader>fp", function()
  vim.fn.system("tmux display-popup -E ~/.local/bin/tmux-sessionizer")
end, { desc = "Switch project" })

-- ── Buffer navigation ─────────────────────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch other buffe" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ── Line moving in visual mode ────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Keep cursor in place when joining lines ───────────────────────────────────
map("n", "J", "mzJ`z", opts)

-- ── Paste without overwriting register ───────────────────────────────────────
map("v", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- ── Diagnostics navigation ───────────────────────────────────────────────────
-- Jump to next/previous diagnostic
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

-- Sauter uniquement aux ERREURS (filtre par sévérité)
map("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

-- ── Quickfix list ─────────────────────────────────────────────────────────────
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

-- ── Indenting in visual mode keeps selection ─────────────────────────────────
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
