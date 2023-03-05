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
        position = "left",
        width = 40,
        mappings = {
            ["o"] = {
                command = "open",
                nowait = true
            },
        }
    },
    event_handlers = {
        {
            event = "neo_tree_window_after_open",
            handler = function(args)
                -- Setup autocmd to automatically enable/disable line number.
                local winid = args.winid
                local bufid = vim.api.nvim_win_get_buf(winid)
                vim.api.nvim_create_augroup("NeotreeLineNumber", { clear = true })
                vim.api.nvim_create_autocmd("BufEnter", {
                    group = "NeotreeLineNumber",
                    buffer = bufid,
                    desc = "Enable line number for Neotree buffer.",
                    command = "setlocal number relativenumber",
                })
                vim.api.nvim_create_autocmd("BufLeave", {
                    group = "NeotreeLineNumber",
                    buffer = bufid,
                    desc = "Disable line number for Neotree buffer.",
                    command = "setlocal nonumber norelativenumber",
                })

                -- Enable line number in the new window.
                vim.api.nvim_win_set_option(winid, "number", true)
                vim.api.nvim_win_set_option(winid, "relativenumber", true)
            end
        },
    },
})
