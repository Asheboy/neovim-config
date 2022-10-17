local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require "telescope.actions"

  vim.cmd([[
    function!   QuickFixOpenAll()
        if empty(getqflist())
            return
        endif
        let s:prev_val = ""
        for d in getqflist()
            let s:curr_val = bufname(d.bufnr)
            if (s:curr_val != s:prev_val)
                exec "edit " . s:curr_val
            endif
            let s:prev_val = s:curr_val
        endfor
    endfunction
  ]])

  telescope.setup({
    defaults = {
      sorting_strategy = 'ascending',
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-o>"] = function(prompt_bufnr) require("telescope.actions").select_default(prompt_bufnr) require("telescope.builtin").resume() end,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-o>"] = function(prompt_bufnr) require("telescope.actions").select_default(prompt_bufnr) require("telescope.builtin").resume() end,
        },
      },
    },
  })
end

return M
