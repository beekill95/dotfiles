-- Quick shortcuts.
local o = vim.opt

-- Enable line number and relative line numbers.
o.nu = true
o.relativenumber = true

-- Indentation.
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- Searching.
o.hlsearch = true
o.incsearch = true

-- Scrolling.
o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")

-- Update time.
o.updatetime = 50

-- I hate wrap line.
o.wrap = false

-- It's a bit disoriented without knowing where your cursor is,
-- hopefully it's better with this option.
o.cursorline = true

o.hidden = true
