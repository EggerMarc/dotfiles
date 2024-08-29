local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")

local on_attach = lsp_zero.on_attach(
    function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
    end)

local capabilities = lsp_zero.capabilities

lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilites = capabilities,
    filetypes = { "typescript", "typescript.tsx", "typescriptreact" },
    root_dir = lspconfig.util.root_pattern( { "package.json", "config.toml" } ),
    settings = {
        completions = {
            completeFunctionCalls = true,
        }
    }
})

lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

