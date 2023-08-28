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

-- Configure language servers.
local lspconfig = require('lspconfig')

-- Configure Python's language servers.
lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            configurationSources = {},
            plugins = {
                pycodestyle = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                }
            }
        }
    }
}
lspconfig.ruff_lsp.setup{}

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
