local bufnoremap = require('dzfrias/util').bufnoremap

vim.api.nvim_set_option_value('tabstop', 2, { scope = 'local' })
vim.api.nvim_set_option_value('shiftwidth', 2, { scope = 'local' })

-- Run the current file
bufnoremap('n', '<leader>r', ':luafile %<CR>')
