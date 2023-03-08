-- Use a protected call so we don't error out on first use
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    vim.notify("Toggleterm plugin not found! Quit configuring!")
    return
end

toggleterm.setup {
    -- Terminal sizes and direction.
    size = 10,
    direction = 'horizontal',
    -- Keymap for opening terminal.
    open_mapping = [[<C-\>]],
    insert_mappings = true,
    terminal_mappings = true,
    -- Don't automatic change directory.
    autochdir = false,
}

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
