-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "lsp-zero")
if not status_ok then
	return
end

local lsp = require('lsp-zero').preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

