vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { '.git' },
})

vim.diagnostic.config({
    -- Use the default configuration
    virtual_lines = true

    -- Alternatively, customize specific options
    -- virtual_lines = {
    --  -- Only show virtual line diagnostics for the current cursor line
    --  current_line = true,
    -- },
})


-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client == nil then
--             return
--         end
--         if client.name == 'ruff' then
--             -- Disable hover in favor of Pyright
--             client.server_capabilities.hoverProvider = false
--         end
--     end,
--     desc = 'LSP: Disable hover capability from Ruff',
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--     -- group = vim.api.nvim_create_augroup('lsp_attach_autocompletion', { clear = true }),
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client:supports_method('textDocument/completion') then
--             vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--         end
--     end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(event)
--         local bufmap = function(mode, rhs, lhs)
--             vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
--         end
--
--         -- These keymaps are the defaults in Neovim v0.11
--         bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
--         bufmap('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>')
--         bufmap('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>')
--         bufmap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>')
--         bufmap('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--         bufmap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
--         bufmap({ 'i', 's' }, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--
--         -- These are custom keymaps
--         bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
--         bufmap('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
--         bufmap('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
--         bufmap({ 'n', 'x' }, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
--
--         -- Enable autocompletion.
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client:supports_method('textDocument/completion') then
--             vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--         end
--     end,
-- })

-- Enable every LSP.
vim.lsp.enable({ "pyright", "ruff" })
