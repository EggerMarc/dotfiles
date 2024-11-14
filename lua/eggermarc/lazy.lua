local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


local plugins = {
    'neovim/nvim-lspconfig',
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.6',
        dependencies = { { 'nvim-lua/plenary.nvim' }, }

    },
    { "catppuccin/nvim",   name = "catppuccin" },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").init {
                icons = true,
                --configs go here
                --leave empty for defaut
            }
        end
    },
    -- Just to override and set ensure_installed
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                opts = {
                    ensure_installed = {
                        "rust-analyzer",
                        "gopls",
                        "denols", -- configure to support Deno
                        "typescript-language-server",
                        "eslint_lsp",
                        "prettier"
                    },
                },
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },


            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },

            --treesitter
            { 'nvim-treesitter/nvim-treesitter'}

        },
    },
    { 'neoclide/coc.nvim', branch = 'release' },

    "theprimeagen/refactoring.nvim",
    "theprimeagen/vim-be-good",
    "folke/zen-mode.nvim",
    "github/copilot.vim",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",
    "brenoprata10/nvim-highlight-colors",
    "jose-elias-alvarez/null-ls.nvim",
    "MunifTanjim/prettier.nvim",
    {
        'Vonr/align.nvim',
        branch = "v2",
    },
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    'simrat39/rust-tools.nvim',
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
    {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
}
}


-- Setup lazy.nvim
require("lazy").setup(plugins, {
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "catppuccin" }, },
    -- automatically check for plugin updates
    checker = { enabled = true },
    {
        ui = {
            -- If you are using a Nerd Font: set icons to an empty table which will use the
            -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    }
})
