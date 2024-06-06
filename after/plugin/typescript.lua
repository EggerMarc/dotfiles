local lsp_zero = require('lsp-zero')

local on_attach = lsp_zero.on_attach(
    function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
    end)

local capabilities = lsp_zero.capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilites = capabilities,
    filetypes = { "typescript", "typescript.tsx", "typescriptreact"},
    settings = {
        completions = {
            completeFunctionCalls = true,
        }
    }
})
