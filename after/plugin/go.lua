
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
-- require gopls
lspconfig.gopls.setup({
    filetypes={"go"},
    root_dir = util.root_pattern({"go.mod", "go.sum"}),
})
