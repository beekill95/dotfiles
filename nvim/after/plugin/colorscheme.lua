-- Use a protected call so we don't error out on first use
local colorscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end
