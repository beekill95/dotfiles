return {
    "akinsho/toggleterm.nvim",
    keys = {
        { "<C-\\>",    ":ToggleTerm",                    mode = "n", desc = "ToggleTerm" },
        { "<leader>l", "<cmd>lua _lazygit_toggle()<CR>", mode = "n", desc = "Toggle LazyGit" },
    },
    config = function()
        local toggleterm = require("toggleterm")
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
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            -- This keymap makes using j to move down in lazygit awkward.
            -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

        -- Lazygit in toggleterm.
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit  = Terminal:new({
            cmd = (jit.os == 'Windows') and "lazygit.exe" or "lazygit",
            dir = "git_dir",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "double",
            },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                local opts = { noremap = true, silent = true }
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
                vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', "<cmd><esc><CR>", opts)
                vim.api.nvim_buf_set_keymap(term.bufnr, 't', [[<C-\>]], "<cmd>close<CR>", opts)
            end,
            -- function to run on closing the terminal
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    end
}
