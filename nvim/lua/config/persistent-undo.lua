local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.undodir = { prefix .. "/nvim/.undo//"}
