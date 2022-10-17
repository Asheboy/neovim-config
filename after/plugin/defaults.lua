local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
-- api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = false
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.history=1000
opt.scrolloff=8
opt.sidescroll=1
opt.sidescrolloff=15
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
--opt.hidden=true
opt.swapfile=false
--opt.iskeyword+=-
--opt.colorcolumn=80,120



-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.cmd([[autocmd CursorMoved * lua vim.diagnostic.open_float({focusable = false})]])
-- vim.cmd([[autocmd CursorMoved * lua print('test')]])
