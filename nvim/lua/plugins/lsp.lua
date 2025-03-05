return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional
        -- Suggestions for functions' signature.
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },             -- Required
        { 'rafamadriz/friendly-snippets' }, -- Optional
    },
    config = function()
        vim.opt.signcolumn = "yes"

        -- Setup mason.
        local mason = require("mason")
        mason.setup {}

        -- Install the required lsp servers.
        local mason_lspconfigs = require("mason-lspconfig")
        mason_lspconfigs.setup {
            ensure_installed = { "pyright", "ruff" },
        }

        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- -- Setup custom keymaps.
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                local opts = { buffer = event.bufnr }
                local keymap = vim.keymap.set

                -- Different keymaps for code actions and renaming.
                keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

                -- Jump to definition and stuffs.
                keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                keymap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            end
        })

        -- -- Configure language servers.
        local lspconfig = require('lspconfig')

        -- Configure Python's language servers.
        lspconfig.pyright.setup {
            settings = {
                pyright = { autoImportCompletion = true, },
                python = {
                    analysis = {
                        ignore = { '*' },
                        -- autoSearchPaths = true,
                        -- diagnosticMode = 'openFilesOnly',
                        -- useLibraryCodeForTypes = true,
                        -- typeCheckingMode = 'off',
                    },
                },
            },
        }

        lspconfig.ruff.setup {
            on_attach = function(client, bufnr)
                if client.name == 'ruff' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end
        }

        -- Configure cmp for autocomplete and suggestions.
        local cmp = require('cmp')

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer',                 keyword_length = 3 },
                { name = 'luasnip',                keyword_length = 2 },
                { name = 'nvim_lsp_signature_help' },
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({}),
        })

        -- Finishing touch.
        -- Show floating diagnostic messages.
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = false,
            float = true,
        })
    end
}
