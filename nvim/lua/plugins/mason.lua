return {
    {
        --"williamboman/mason.nvim",
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensured_installed = { "ruff", "pyright", "pyrefly" }
        },
    },
}
