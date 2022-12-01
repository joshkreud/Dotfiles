local opt = vim.opt -- Set options (global/buffer/windows-scoped)


-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.guicursor = ""
opt.mouse = 'a' -- Enable mouse support
opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-----------------------------------------------------------
-- File Explorer
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- Editor
-----------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.wrap = false -- No line wrap
opt.scrolloff = 8
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.colorcolumn = "120"
opt.incsearch = true -- Incremental search
opt.hlsearch = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event
