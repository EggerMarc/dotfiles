-- Python: pyright for type checking/hints, ruff for linting/formatting
-- Detect uv venv automatically
local function get_python_path(workspace)
    local uv_venv = workspace .. "/.venv/bin/python"
    if vim.fn.executable(uv_venv) == 1 then
        return uv_venv
    end
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        return venv .. "/bin/python"
    end
    return vim.fn.exepath("python3") or "python"
end

vim.lsp.config('pyright', {
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "requirements.txt", "setup.py" },
    on_init = function(client)
        local root = client.config.root_dir
        if root then
            client.config.settings.python = client.config.settings.python or {}
            client.config.settings.python.pythonPath = get_python_path(root)
            local venv_path = root .. "/.venv"
            if vim.fn.isdirectory(venv_path) == 1 then
                client.config.settings.python.venvPath = root
                client.config.settings.python.venv = ".venv"
            end
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

vim.lsp.config('ruff', {
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "requirements.txt" },
})

vim.lsp.config('gopls', {
    filetypes = { "go", "golang" },
    root_markers = { "go.mod", "go.sum" },
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

vim.lsp.config('lua_ls', {
    filetypes = { "lua" },
    root_markers = { "init.lua", ".luarc.json" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

vim.lsp.config('tailwindcss', {})

vim.lsp.config('julials', {
    filetypes = { "julia", "jl" },
    root_markers = { "Project.toml" },
})

vim.lsp.config('r_language_server', {
    filetypes = { "r" },
})

vim.lsp.config('jsonls', {})

vim.lsp.config('csharp_ls', {})

vim.lsp.config('cssls', {})

vim.lsp.enable({
    'pyright', 'ruff', 'gopls', 'lua_ls', 'tailwindcss',
    'julials', 'r_language_server', 'jsonls', 'csharp_ls', 'cssls',
})
