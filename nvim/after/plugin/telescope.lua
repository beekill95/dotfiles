local status_ok, packer = pcall(require, "telescope.builtin")
if not status_ok then
	return
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
