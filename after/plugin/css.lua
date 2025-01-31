vim.opt.termguicolors = true

require("cmp").setup({
    formatting = {
        format = require("nvim-highlight-colors").format
    }
})

-- VIM CSS Color highlight
require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol='●',
    virtual_prefix='  ',
    virtual_symbol_position='eow',
    enable_tailwind = true
})

local lspconfig = require('lspconfig');

lspconfig.cssls.setup({})
