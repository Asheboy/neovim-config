local M = {}

function M.setup()
  local status_ok, fterm = pcall(require, "FTerm")
  if not status_ok then
    return
  end

	local tig = fterm:new({
		ft = 'fterm_tig',
		cmd = "tig status",
		dimensions = {
			height = 0.9,
			width = 0.9
		}
	})

	-- Use this to toggle gitui in a floating terminal
	vim.keymap.set('n', '<A-g>', function()
		tig:toggle()
	end)
	vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
	vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

return M

