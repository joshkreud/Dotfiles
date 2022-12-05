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

-- Fugitive
map('n', "<leader>gs", "<cmd>:Git<CR>")

-- Code Runner
map('n', '<leader>r', ':RunCode<CR>', { silent = false })
map('n', '<leader>rf', ':RunFile<CR>', { silent = false })
map('n', '<leader>rft', ':RunFile tab<CR>', { silent = false })
map('n', '<leader>rp', ':RunProject<CR>', { silent = false })
map('n', '<leader>rc', ':RunClose<CR>', { silent = false })
map('n', '<leader>crf', ':CRFiletype<CR>', { silent = false })
map('n', '<leader>crp', ':CRProjects<CR>', { silent = false })

-- Telescope
map('n', '<leader>ff', ":Telescope find_files<CR>")
map('n', '<leader>fg', ":Telescope live_grep<CR>")
map('n', '<leader>fb', ":Telescope buffers<CR>")
map('n', '<leader>fc', ":Telescope commands<CR>")
map('n', '<leader>fk', ":Telescope keymaps<CR>")
map('n', '<leader>fr', ":Telescope repo<CR>")
map('n', '<leader>fh', ":Telescope help_tags<CR>")

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>') -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>') -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>') -- search file
