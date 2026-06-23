-- GPU / shader languages: WGSL, CUDA, Metal, GLSL, HLSL
-- Treesitter parsers (wgsl/cuda/glsl/hlsl, plus cpp for Metal) live in lazy.lua.
-- This file wires filetype detection + LSP (which provides AST, diagnostics/lint,
-- hover and inlay hints). Install the servers once with:
--   :MasonInstall wgsl-analyzer glsl_analyzer clangd

-- Filetype detection ---------------------------------------------------------
vim.filetype.add({
    extension = {
        -- WGSL (WebGPU shading language)
        wgsl = "wgsl",

        -- CUDA (Neovim usually maps these already; set explicitly to be safe)
        cu = "cuda",
        cuh = "cuda",

        -- Metal is C++14 under the hood -> reuse the cpp parser + clangd
        metal = "cpp",

        -- GLSL stages
        glsl = "glsl",
        vert = "glsl",
        frag = "glsl",
        geom = "glsl",
        comp = "glsl",
        tesc = "glsl",
        tese = "glsl",
        rgen = "glsl",
        rchit = "glsl",
        rmiss = "glsl",
        rahit = "glsl",
        rcall = "glsl",

        -- HLSL
        hlsl = "hlsl",
        fx = "hlsl",
        fxh = "hlsl",
    },
})

-- LSP servers ----------------------------------------------------------------

-- WGSL: wgsl-analyzer (AST, diagnostics, hover, inlay hints)
vim.lsp.config('wgsl_analyzer', {
    filetypes = { "wgsl" },
    root_markers = { "Cargo.toml", ".git" },
})

-- GLSL: glsl_analyzer (diagnostics from glslangValidator-style checks, hover)
vim.lsp.config('glsl_analyzer', {
    filetypes = { "glsl", "vert", "frag", "geom", "comp", "tesc", "tese" },
})

-- CUDA + Metal (+ C/C++): clangd. Real CUDA support; Metal parses as C++.
vim.lsp.config('clangd', {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
})

vim.lsp.enable({ 'wgsl_analyzer', 'glsl_analyzer', 'clangd' })
