
local lspconfig = require("lspconfig")
local capabilities = lsp_zero.capabilities
local util = require "lspconfig/util"

-- require pyright 

lspconfig.pyright.setup({
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = util.root_pattern("poetry.toml"),
})

