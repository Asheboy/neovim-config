local M = {}

function M.setup()
  local status_ok, whichkey = pcall(require, "lualine")
  if not status_ok then
    return
  end

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {
				{
					'filename',
					path = 1,
					symbols = {
						modified = '[YOU HAVEN‘T SAVED ME]',      -- Text to show when the file is modified.
						readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
						unnamed = '[No Name]', -- Text to show for unnamed buffers.
						newfile = '[New]',     -- Text to show for new created file before first writting
					}
				}
			},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

return M
