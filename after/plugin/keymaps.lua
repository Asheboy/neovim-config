local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local builtin = require('telescope.builtin')

-- escape using jj or kk in insert and terminal mode
vim.keymap.set("i", "jj", "<ESC>", default_opts)
vim.keymap.set("i", "kk", "<ESC>", default_opts)

-- remap ; to :
vim.keymap.set("n", ";", ":", default_opts)

-- Visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
vim.keymap.set("v", "<", "<gv", default_opts)
vim.keymap.set("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', default_opts)

-- Switch buffer
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", default_opts)
vim.keymap.set("n", "<S-l>", ":bnext<CR>", default_opts)
vim.keymap.set("n", "gh", ":bprevious<CR>", default_opts)
vim.keymap.set("n", "gl", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", default_opts)
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", default_opts)


-- Resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", default_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", default_opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", default_opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", default_opts)

vim.keymap.set('n', '<Leader>o', builtin.find_files, {})
vim.keymap.set('n', '\\', builtin.live_grep, {})
vim.keymap.set('n', '<Leader><cr>', builtin.buffers, {})


-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
