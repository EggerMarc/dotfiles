-- Rust tools config

local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end
    }
})

-- Rust-analyzer configs
local lsp_zero = require('lsp-zero')

local on_attach = lsp_zero.on_attach(
    function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
    end)

local capabilities = lsp_zero.capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust-analyzer'] = {
        imports = {
            granularity = {
               group = "module",
            },
            prefix = "self",
        },
        cargo = {
            allFeatures = true,
            buildScripts = {
                enable = true,
                },
        },
        procMacro = {
            enable = true
        },
        add_return_type = {
            enable = true
        },
        inlayHints = {
            enable = true,
            showParameterNames = true,
            parameterHintsPrefix = "<- ",
            otherHintsPrefix = "=> ",
            }
        },
        diagnostics = {
            enable = true;
        }
    }
})

vim.diagnostic.config({
    virtual_text = true
})
