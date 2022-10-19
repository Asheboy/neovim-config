local M = {}
local lsputils = require "config.lsp.utils"
CONFIG = {}
function M.setup()
  local null_ls = require "null-ls"
  local sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.prettierd
  }
  null_ls.config { sources = sources }
lsputils.setup_server("null-ls", CONFIG)
end
return M
