local M = {}

function M.setup()
  local status_ok, tree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded = 1
  vim.g.loaded_netrwPlugin = 1

	vim.keymap.set('n', '<tab><tab>', ':NvimTreeToggle<cr>')
	vim.keymap.set('n', '<Leader>f', ':NvimTreeFindFile<cr>')

  -- empty setup using defaults
  tree.setup({
    remove_keymaps = {"<Tab>"}
  })

  -- -- OR setup with some options
  -- require("nvim-tree").setup({
  --   sort_by = "case_sensitive",
  --   view = {
  --     adaptive_size = true,
  --     mappings = {
  --       list = {
  --         { key = "u", action = "dir_up" },
  --       },
  --     },
  --   },
  --   renderer = {
  --     group_empty = true,
  --   },
  --   filters = {
  --     dotfiles = true,
  --   },
  -- })
end

return M
