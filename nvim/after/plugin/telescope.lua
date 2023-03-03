local status_ok, builtin = pcall(require, "telescope.builtin")
if not status_ok then
    vim.notify("Telescope plugin not found! Quit configuring!")
    return
end

vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
