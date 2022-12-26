-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- azerty mapping"
keymap("n", "<c-$>", "c-]", default_opts) -- jumpto to tag in help 
-- deactiate arrow keys
keymap("n", "<up>", "", default_opts)
keymap("n", "<down>", "", default_opts)
-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

keymap("i", "<C-s>", "<ESC>:w<CR>", default_opts)
keymap("n", "<C-s>", ":w<CR>", default_opts)
keymap("n", "<C-q>", ":qa<CR>", default_opts)
-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
-- keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
-- keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- -- Always center
-- keymap("n", "k", "kzz", default_opts)
-- keymap("n", "j", "jzz", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)
-- Paste line above or below
keymap("n", "(p", ":pu!<cr>")
keymap("n", ")p", ":pu<cr>")

-- Switch buffer
keymap("n", "<right>", ":BufferLineCycleNext<CR>", default_opts)
keymap("n", "<left>", ":BufferLineCyclePrev<CR>", default_opts)
-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move current line / bloselectedck of text in visual mode
keymap("n", "<A-j>", ":m .+1<CR>==", default_opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", default_opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", default_opts)
keymap("n", "<A-k>", ":m .-2<CR>==", default_opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", default_opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", default_opts)

-- Resizing panes
keymap("n", "<S-Left>", ":vertical resize +2<CR>", default_opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", default_opts)
keymap("n", "<S-Up>", ":resize +2<CR>", default_opts)
keymap("n", "<S-Down>", ":resize -2<CR>", default_opts)

-- Insert blank line
keymap("n", ")<Space>", "o<Esc>", default_opts)
keymap("n", "(<Space>", "O<Esc>", default_opts)


-- windows.nvim
-- keymap("n", "<C-w>z", "<Cmd>WindowsMaximize<CR>", default_opts)

