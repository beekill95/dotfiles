-- Default configuration from:
-- https://github.com/MrcJkb/haskell-tools.nvim#quick-setup
local status_ok, ht = pcall(require, "haskell-tools")
if not status_ok then
    vim.notify("Haskell-tools plugin not found! No keymap is set for haskell files.")
    return
end

local def_opts = { noremap = true, silent = true, }
vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
-- ht.setup {
--     hls = {
--         debug = false,
--         on_attach = function(client, bufnr)
--             local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })

--             -- haskell-language-server relies heavily on codeLenses,
--             -- so auto-refresh (see advanced configuration) is enabled by default
--             vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
--             vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
--             vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
--         end,
--         default_settings = {
--             haskell = {
--                 formattingProvider = 'ormolu',
--                 -- FIXME: Disable auto formatting for cabal files,
--                 -- because it doesn't allow the files to be editted.
--                 -- cabalFormattingProvider = 'cabalfmt',
--                 cabalFormattingProvider = '',
--             },
--         },
--     },
-- }
