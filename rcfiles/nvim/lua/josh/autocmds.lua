local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
    end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})

augroup('setLineLength', { clear = true })
autocmd('Filetype', {
    group = 'setLineLength',
    pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
    command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
    group = 'setIndent',
    pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
        'yaml', 'lua', "py"
    },
    command = 'setlocal shiftwidth=2 tabstop=2'
})