local opts = { noremap = true }

-- Leader.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Shoten kepmap function.
local keymap = vim.keymap.set

-- Open default file explorer.
-- keymap("n", "<C-e>", vim.cmd.Ex, opts)

-- WINDOWS.
-- Move between windows.
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Resize windows.
keymap("n", "<C-Up>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Down>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-S-Down>", ":resize -2<CR>", opts)

-- TEXT SELECTION.
-- Move text up and down.
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
