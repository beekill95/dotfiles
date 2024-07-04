return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        -- Move up and down telescope list.
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                }
            }
        }

        -- Mappings for opening telescope.
        local builtin = require("telescope.builtin")
        local opts = { noremap = true }
        local keymap = vim.keymap.set

        keymap('n', '<C-f>', builtin.find_files, opts)
        keymap('n', '<C-p>', builtin.git_files, opts)
        keymap('n', '<leader>b', builtin.buffers, opts)
    end
}
