local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")
local util = require('lspconfig/util')

local on_attach = lsp_zero.on_attach(
    function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end)

-- Configure Deno's LSP (denols)
lspconfig.denols.setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Disable TypeScript server if it's causing issues
        if client.name == "ts_ls" then
            client.stop()
        end
    end,
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
    init_options = {
        lint = true,
        unstable = true,
        suggest = {
            imports = {
                hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true
                }
            }
        }
    }
}

-- Configure tsserver but exclude it from Deno projects
lspconfig.ts_ls.setup {
    on_attach = function(client, bufnr)
        local root_dir = client.config.root_dir
        if root_dir and (util.path.exists(util.path.join(root_dir, "deno.json")) or
                util.path.exists(util.path.join(root_dir, "deno.jsonc"))) then
            client.stop() -- Disable tsserver in Deno projects
        else
            on_attach(client, bufnr)
        end
    end,
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
}
