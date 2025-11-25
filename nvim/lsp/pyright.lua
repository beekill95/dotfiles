return {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml", ".git" },
    filetypes = { "python" },
    settings = {
        pyright = {
            autoImportCompletion = true,
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Use ruff's for everything.
                ignore = { '*' },
            },
        },
    },
}
