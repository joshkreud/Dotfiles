local keymap = vim.keymap -- Set options (global/buffer/windows-scoped)

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " " -- Leader key Space

map('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
map('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
map('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
map('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
map('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
map('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
map('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })


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
