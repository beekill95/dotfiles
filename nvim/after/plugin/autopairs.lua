-- Use a protected call so we don't error out on first use
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    vim.notify("Autopairs plugin not found! Quit configuring!")
    return
end

autopairs.setup {}

-- Integration with cmp.
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
    vim.notify("Cmp plugin not found! Quit configuring autopairs integration with cmp!")
end
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
