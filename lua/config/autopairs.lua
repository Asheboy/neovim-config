local M = {}

function M.setup()
  local npairs = require "nvim-autopairs"
  npairs.setup {
    check_ts = false,
  }
  npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
end

return M
