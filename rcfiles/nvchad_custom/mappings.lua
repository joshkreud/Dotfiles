---@type MappingsTable
local M = {}

M.general = {

	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "window left" },
		["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "window right" },
		["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "window down" },
		["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "window up" },
		["<C-s>"] = { "<cmd>w<CR><ESC>" },
	},
	i = {
		["<C-s>"] = { "<cmd>w<CR><ESC>" },
	},
	v = {
		["<C-s>"] = { "<dmc>w<CR><ESC>" },
	},
}

-- more keybinds!

return M
