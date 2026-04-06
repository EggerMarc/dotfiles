-- Formatting handled by conform.nvim
-- Format keybind
vim.keymap.set("n", "<Leader>f", function()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end, { desc = "Format buffer" })

vim.keymap.set("x", "<Leader>f", function()
    require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
end, { desc = "Format selection" })
