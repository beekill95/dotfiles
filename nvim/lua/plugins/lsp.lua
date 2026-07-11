return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "saghen/blink.cmp",                         version = "1.*" },
        { "rafamadriz/friendly-snippets" },
        { "mason-org/mason.nvim" },
        { "mason-org/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- Define servers' settings here.
        servers = {
            pyrefly = {
                settings = {
                    python = {
                        pyrefly = {
                            typeCheckingMode = "default",
                        },
                    },
                },
            },
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

        -- Config blink completion.
        local blink = require("blink.cmp")
        blink.setup({
            completion = {
                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                -- Display a preview of the selected item on the current line
                ghost_text = { enabled = true },
            },
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


        -- Config the servers based on the `opts` field above.
        for server, config in pairs(opts.servers) do
            config.capabilities = blink.get_lsp_capabilities(config.capabilities)
            vim.lsp.config(server, config)
        end

        -- Config format on save.
        local format_group_name = "LspFormatting"
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(format_group_name, { clear = true }),
            desc = "Format on save globally",
            callback = function(event)
                local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

                -- Clear duplicate save hooks.
                vim.api.nvim_clear_autocmds({ group = format_group_name, buffer = event.buf })

                -- Enable format on save.
                if client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = format_group_name,
                        buffer = event.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end
        })

        -- Config custom keymaps.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
            desc = "Custom keymaps for LSPs",
            callback = function(event)
                local _opts = { buffer = event.buf }

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, _opts)
            end
        })
    end,
}
