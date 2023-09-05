-- Use a protected call so we don't error out on first use
local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    vim.notify("Lsp-zero plugin not found! Quit configuring!")
    return
end

lsp.preset({
    name = 'recommended',
    -- Disable default keymaps for renaming, code actions.
    set_lsp_keymaps = { omit = {"<F2>", "<F4>"} },
})

-- Setup custom keymaps.
lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr }
    local keymap = vim.keymap.set

    -- Different keymaps for code actions and renaming.
    keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap("n", "<leader>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end)

lsp.skip_server_setup({'pylsp', 'pyright', 'efm'})

-- Configure language servers.
local lspconfig = require('lspconfig')

-- Configure Python's language servers.
-- lspconfig.pylsp.setup {
--     settings = {
--         pylsp = {
--             configurationSources = {},
--             plugins = {
--                 autopep8 = { enabled = false, },
--                 pycodestyle = { enabled = false, },
--                 pyflakes = { enabled = false, },
--                 flake8 = { enabled = false, },
--                 pyls_isort = { enabled = false, },
--                 mccabe = { enabled = false, },
--                 pylint = { enabled = false, },
--                 yapf = { enabled = true, },
--                 jedi_completion = {
--                     enabled = true,
--                     fuzzy = true,
--                     cache_for = { 'pandas', 'numpy', 'tensorflow', 'matplotlib', 'keras-core', 'torch' },
--                 },
--             }
--         }
--     }
-- }
lspconfig.pyright.setup {
    settings = {
        pyright = {autoImportCompletion = true,},
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off',
            },
        },
    },
}
lspconfig.ruff_lsp.setup{}

-- Efm: general purpose language server.
lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = { '.git/' },
        languages = {
            python = {
                { formatCommand = 'yapf --quiet', formatStdin = true }
            }
        }
    }
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
