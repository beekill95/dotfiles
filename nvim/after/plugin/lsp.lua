-- Use a protected call so we don't error out on first use
local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
    vim.notify("Lsp-zero plugin not found! Quit configuring!")
    return
end

lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.setup()

