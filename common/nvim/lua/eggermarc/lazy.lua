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
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.6',
        dependencies = { { 'nvim-lua/plenary.nvim' }, }

    },
    { "catppuccin/nvim",   name = "catppuccin" },
    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                "javascript", "typescript", "tsx",
                "rust",
                "python",
                "c", "cpp",
                "lua", "vim", "vimdoc",
                "query", "toml", "json",
                "go"
            },
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby', 'markdown' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",

    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
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
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    "theprimeagen/refactoring.nvim",
    "theprimeagen/vim-be-good",
    "folke/zen-mode.nvim",
    "github/copilot.vim",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",
    "brenoprata10/nvim-highlight-colors",
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                less = { "prettier" },
                scss = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 2000,
                lsp_fallback = true,
            },
        },
    },
    {
        'Vonr/align.nvim',
        branch = "v2",
    },
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
    },
    {
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    'nvim-tree/nvim-web-devicons',
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
        opts = {
            server = {
                default_settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true, -- Use the boolean flag for "all"
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.g.rustaceanvim = opts
        end,
    },
    'mfussenegger/nvim-dap',
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dim = { enabled = true },
            git = { enabled = true },
            gitbrowse = { enabled = true },
            image = { enabled = true },
            indent = { enabled = true },
            notifier = { enabled = true },
            profiler = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^4', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        opts = {
            provider = "gemini",
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "echasnovski/mini.pick",
            "nvim-telescope/telescope.nvim",
            "hrsh7th/nvim-cmp",
            "ibhagwan/fzf-lua",
            "nvim-tree/nvim-web-devicons",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    },
                },
            },
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
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
