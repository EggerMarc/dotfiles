local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local capabilities = lsp_zero.capabilities
local util = require "lspconfig.util"

-- Python: pyright for type checking/hints, ruff for linting/formatting
-- Detect uv venv automatically
local function get_python_path(workspace)
    -- Check for uv venv
    local uv_venv = workspace .. "/.venv/bin/python"
    if vim.fn.executable(uv_venv) == 1 then
        return uv_venv
    end
    -- Check VIRTUAL_ENV env var
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        return venv .. "/bin/python"
    end
    return vim.fn.exepath("python3") or "python"
end

lspconfig.pyright.setup({
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = util.root_pattern({ "pyproject.toml", "requirements.txt", "setup.py" }),
    before_init = function(_, config)
        local root = config.root_dir
        config.settings.python.pythonPath = get_python_path(root)
        -- Tell pyright where the venv is so it resolves installed packages
        local venv_path = root .. "/.venv"
        if vim.fn.isdirectory(venv_path) == 1 then
            config.settings.python.venvPath = root
            config.settings.python.venv = ".venv"
        end
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
})

lspconfig.ruff.setup({
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = util.root_pattern({ "pyproject.toml", "requirements.txt" }),
})

-- Go require gopls
lspconfig.gopls.setup({
    filetypes = { "go", "golang" },
    root_dir = util.root_pattern({ "go.mod", "go.sum" }),
    capabilities = capabilities,
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
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
