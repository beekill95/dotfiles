return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    lazy = false,
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
        -- Setup mason.
        local mason = require("mason")
        mason.setup {}

        -- Install the required lsp servers.
        local mason_lspconfigs = require("mason-lspconfig")
        mason_lspconfigs.setup {
            ensure_installed = { "pyright", "ruff" },
        }

        local lsp = require("lsp-zero")
        lsp.preset({
            name = 'recommended',
            -- Disable default keymaps for renaming, code actions.
            set_lsp_keymaps = { omit = {"<F2>", "<F4>"} },
        })

        -- -- Setup custom keymaps.
        lsp.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr }
            local keymap = vim.keymap.set

            -- Different keymaps for code actions and renaming.
            keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end)

        lsp.skip_server_setup({'pyright', 'ruff'})

        -- -- Configure language servers.
        local lspconfig = require('lspconfig')

        -- Configure Python's language servers.
        lspconfig.pyright.setup {
            settings = {
                pyright = {autoImportCompletion = true,},
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

        lspconfig.ruff.setup{
            on_attach=function(client, bufnr)
                if client.name == 'ruff' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end
        }

        lsp.nvim_workspace()
        lsp.setup()

        -- Configure cmp for autocomplete and suggestions.
        local cmp = require('cmp')

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer', keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'nvim_lsp_signature_help' },
            },
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
