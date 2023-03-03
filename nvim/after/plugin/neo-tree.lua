local status_ok, packer = pcall(require, "neo-tree")
if not status_ok then
	return
end

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
