return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
}
