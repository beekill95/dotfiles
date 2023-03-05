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

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

-- Show floating errors.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
