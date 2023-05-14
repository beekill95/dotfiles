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
})

-- Automatically show/hide line number in neotree buffer when enter/leave.
local function setupLineNumberInNeotreeBuffer()
    vim.api.nvim_create_autocmd({"BufEnter", "BufLeave"}, {
        group = vim.api.nvim_create_augroup("NeotreeLineNumber", { clear = true }),
        desc = "Enable/Disable line number for Neotree buffer.",
        -- command = "setlocal number relativenumber",
        callback = function(args)
            if vim.bo[args.buf].filetype == 'neo-tree' then
                if args.event == 'BufEnter' then
                    vim.cmd "setlocal number relativenumber"
                else
                    vim.cmd "setlocal nonumber norelativenumber"
                end
            end
        end,
    })
end
setupLineNumberInNeotreeBuffer()
