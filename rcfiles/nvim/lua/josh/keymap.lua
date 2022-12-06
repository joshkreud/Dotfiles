local keymap = vim.keymap -- Set options (global/buffer/windows-scoped)

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " -- Leader key Space

-- Global Remaps
map('n', "<C-d>","<C-d>zz") -- Center Cursor vert after skip half page
map('n', "<C-u>","<C-u>zz") -- Center cursor vert after skip half page
map('n', "<C-s>", "<cmd>w<cr>") -- Control S save
map('i', "<c-s>", "<ESC><cmd>w<cr>a") -- Control s save in insert mode

-- Fugitive
map('n', "<leader>gs", "<cmd>Git<CR>")

-- Code Runner
map('n', '<leader>r', '<cmd>RunCode<CR>', { silent = false })
map('n', '<leader>rf', '<cmd>RunFile<CR>', { silent = false })
map('n', '<leader>rft', '<cmd>RunFile tab<CR>', { silent = false })
map('n', '<leader>rp', '<cmd>RunProject<CR>', { silent = false })
map('n', '<leader>rc', '<cmd>RunClose<CR>', { silent = false })
map('n', '<leader>crf', '<cmd>CRFiletype<CR>', { silent = false })
map('n', '<leader>crp', '<cmd>CRProjects<CR>', { silent = false })

-- Telescope
map('n', '<leader>ff', "<cmd>Telescope find_files<CR>")
map('n', '<leader>fg', "<cmd>Telescope live_grep<CR>")
map('n', '<leader>fb', "<cmd>Telescope buffers<CR>")
map('n', '<leader>fc', "<cmd>Telescope commands<CR>")
map('n', '<leader>fk', "<cmd>Telescope keymaps<CR>")
map('n', '<leader>fr', "<cmd>Telescope repo<CR>")
map('n', '<leader>fh', "<cmd>Telescope help_tags<CR>")

-- NvimTree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>') -- open/close
map('n', '<leader>f', '<cmd>NvimTreeRefresh<CR>') -- refresh
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>') -- search file

-- LSP
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>' )
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')
