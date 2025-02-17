local lspconfig = require('lspconfig');
lspconfig.sourcekit.setup({
    -- capabilities = capabilities,
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
})
