local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local capabilities = lsp_zero.capabilities
local util = require "lspconfig.util"

-- Python require pyright
lspconfig.pyright.setup({
    capabilities = capabilities,
    filetypes = { "python", "py" },
    root_dir = util.root_pattern({ "pyproject.toml", "requirements.txt" }),
})

lspconfig.pylsp.setup({
    filetypes = { "python", "py" },
    root_dir = util.root_pattern({ "pyproject.toml", "requirements.txt" })
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
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostic = {
                globals = { "vim" }
            }
        }
    }
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

-- JSON require jsonls / json-lsp
lspconfig.jsonls.setup({})

lspconfig.csharp_ls.setup({})
