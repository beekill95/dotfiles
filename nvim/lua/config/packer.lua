-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    end
end

ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return packer.startup(function(use)
    -- Packer can manage itself.
    use 'wbthomason/packer.nvim'

    -- Fuzzy file finder.
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Colorscheme.
    use 'morhetz/gruvbox'

    -- Syntax highlighting.
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- Purescript support.
    use 'purescript-contrib/purescript-vim'
    -- Hy language support.
    use 'hylang/vim-hy'

    -- LSP.
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },           -- Required
            { 'williamboman/mason.nvim' },         -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },       -- Required
            { 'hrsh7th/cmp-nvim-lsp' },   -- Required
            { 'hrsh7th/cmp-buffer' },     -- Optional
            { 'hrsh7th/cmp-path' },       -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },   -- Optional
            -- Suggestions for functions' signature.
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },           -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    -- Automatically insert closing parenthesis.
    use 'windwp/nvim-autopairs'
    -- Haskell support.
    use {
        'mrcjkb/haskell-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim', -- optional
        },
        branch = '1.x.x',                    -- recommended
    }

    -- Git integration.
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    -- Floating terminal.
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
    }

    -- File explorer.
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- Undo Tree.
    use 'mbbill/undotree'

    -- Quick comment.
    use "tpope/vim-commentary"

    -- Change surround.
    use "tpope/vim-surround"

    -- Enable . command in vim to work with plugins' mappings,
    -- such as vim-surround.
    use "tpope/vim-repeat"

    -- For note taking.
    -- use {
    --     "nvim-neorg/neorg",
    --     rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim", "pathlib.nvim" },
    --     tag = "2.x", -- Pin Neorg to the latest stable release
    --     config = function()
    --         require("neorg").setup()
    --     end,
    -- }
    -- Try this for note taking.
    -- use {
    --     'renerocksai/telekasten.nvim',
    --     requires = {'nvim-telescope/telescope.nvim'}
    -- }
    use({
        "epwalsh/obsidian.nvim",
        tag = "*",   -- recommended, use latest release instead of latest commit
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        }
    })

    -- Sending code to REPL.
    -- use "jpalardy/vim-slime"
    use { 'Vigemus/iron.nvim' }
end)
