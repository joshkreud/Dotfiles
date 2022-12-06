require("josh.settings")
require("josh.packer")
require("josh.plugin_startup")
require("josh.autocmds")
require("josh.keymap")
require("josh.lsp")

-- Colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
