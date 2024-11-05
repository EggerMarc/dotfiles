-- vim.cmd("language en_US") -- No need on linux

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end

require("eggermarc")
