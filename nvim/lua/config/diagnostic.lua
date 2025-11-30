vim.diagnostic.config({
    --virtual_lines = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = true,
})

-- Show diagnostic floating when hovering on the texts.
-- Copied from https://oneofone.dev/post/neovim-diagnostics-float/
local group = vim.api.nvim_create_augroup('floating_diagnostic', {})
local function au(typ, pattern, cmdOrFn)
	if type(cmdOrFn) == 'function' then
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
	else
		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
	end
end

au({ 'CursorHold', 'InsertLeave' }, nil, function()
	local opts = {
		focusable = false,
		scope = 'cursor',
		close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
	}
	vim.diagnostic.open_float(nil, opts)
end)

au('InsertEnter', nil, function()
	vim.diagnostic.enable(false)
end)

au('InsertLeave', nil, function()
	vim.diagnostic.enable(true)
end)

