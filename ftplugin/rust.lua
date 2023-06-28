local bufnoremap = require('dzfrias/util').bufnoremap

vim.opt_local.colorcolumn = '100'

bufnoremap('n', '<leader>dd', '<Cmd>RustDebuggables<CR>')
