-- Keymap.
vim.keymap.set("n", "<C-e>", ":NeoTreeFocusToggle<cr>", {})

-- Config.
require("neo-tree").setup({
    window = {
        mappings = {
            ["o"] = {
                command = "open",
                nowait = true
            },
        }
    }
})
