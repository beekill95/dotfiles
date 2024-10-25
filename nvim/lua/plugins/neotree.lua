return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<C-e>", ":NeoTreeFocusToggle<cr>", mode="n", desc = "NeoTree" },
    },
    config = function()
        -- -- Keymap.
        local opts = { noremap = true }
        vim.keymap.set("n", "<C-e>", ":NeoTreeFocusToggle<cr>", opts)
        vim.keymap.set("n", "<leader>nr", ":NeoTreeReveal<cr>", opts)

        -- -- Config.
        local neo_tree = require("neo-tree")
        neo_tree.setup({
            default_component_configs = {
                git_status = {
                    symbols = {
                        unstaged = '☐',
                    },
                },
            },
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

        -- -- Automatically show/hide line number in neotree buffer when enter/leave.
        local function setupLineNumberInNeotreeBuffer()
            vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
                group = vim.api.nvim_create_augroup("NeotreeLineNumber", { clear = true }),
                desc = "Enable/Disable line number for Neotree buffer.",
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
    end,
}
