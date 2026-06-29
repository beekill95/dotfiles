return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "saghen/blink.cmp", version = "1.*" },
        { "rafamadriz/friendly-snippets" },
        { "mason-org/mason.nvim" },
        { "mason-org/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- Define servers' settings here.
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        }
                    }
                }
            }
        }
    },
    config = function(_, opts)
        -- Config mason-related tools.
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
            ensure_installed = { "lua_ls", "pyrefly", "ruff" }
        })

        -- Config the servers based on the `opts` field above.
        for server, config in pairs(opts.servers) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            vim.lsp.config(server, config)
        end

        require("blink.cmp").setup({
            -- Show documentation when selecting a completion item
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            -- Display a preview of the selected item on the current line
            ghost_text = { enabled = true },
            -- Show signatures.
            signature = { enabled = true },
            keymap = {
                -- TODO: config this keymap back to what I used to.
                preset = "default",

                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
        })
    end,
}
