local status_ok, builtin = pcall(require, "telescope.builtin")
if not status_ok then
    vim.notify("Telescope plugin not found! Quit configuring!")
    return
end

local opts = { noremap = true }
local keymap = vim.keymap.set

keymap('n', '<C-f>', builtin.find_files, opts)
keymap('n', '<C-p>', builtin.git_files, opts)
keymap('n', '<leader>b', builtin.buffers, opts)
