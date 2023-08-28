-- Use a protected call so we don't error out on first use
local status_ok, mason = pcall(require, "mason-lspconfig")
if not status_ok then
    vim.notify("Mason-Lspconfig plugin not found! Quit configuring!")
    return
end

mason.setup {
    ensure_installed = { "pylsp", "ruff_lsp" },
}
