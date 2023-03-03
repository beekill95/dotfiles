local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
    vim.notify("Neo-tree plugin not found! Quit configuring!")
    return
end

-- Keymap.
vim.keymap.set("n", "<C-e>", ":NeoTreeFocusToggle<cr>", {})

-- Config.
neo_tree.setup({
    window = {
        mappings = {
            ["o"] = {
                command = "open",
                nowait = true
            },
        }
    }
})
