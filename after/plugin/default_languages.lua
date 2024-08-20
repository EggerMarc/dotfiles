local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local capabilities = lsp_zero.capabilities
local util = require "lspconfig/util"

-- Python require pyright
lspconfig.pyright.setup({
    capabilities = capabilities,
    filetypes = { "python", "py" },
    root_dir = util.root_pattern("poetry.toml"),
})

-- Go require gopls
lspconfig.gopls.setup({
    filetypes = { "go", "golang" },
    root_dir = util.root_pattern({ "go.mod", "go.sum" }),
    capabilities = capabilities
})

-- CSS require css-lsp
-- lspconfig.css_lsp.setup({
--     filetypes = "css",
-- })

-- Lua require lua_ls
lspconfig.lua_ls.setup({
    filetypes = { "lua" },
    root_dir = util.root_pattern({ "init.lua" }),
    capabilities = capabilities
})

-- TailwindCSS require tailwindcss 
lspconfig.tailwindcss.setup({}) -- #TODO

-- Julia require julials
lspconfig.julials.setup({
    filetypes = { "julia", "jl" },
    root_dir = util.root_pattern({ "Project.toml" })
})

-- R require require r_languageserver
lspconfig.r_language_server.setup({
    filetypes = { "r" }
})
