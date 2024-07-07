-- Enable autoread,
-- because I usually edit files in Jupyter Notebook,
-- and then go back to vim for further editting.
vim.api.nvim_command(":set autoread")
vim.api.nvim_create_autocmd({"FocusGained", "CursorHold"}, {
    group = vim.api.nvim_create_augroup("reload_python_notebook", { clear = true }),
    -- Usually, this is just .py files.
    pattern = { "*.py" },
    command = ":checktime",
})
