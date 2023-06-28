local bufnoremap = require('dzfrias/util').bufnoremap

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- For the Jinja2 template engine
bufnoremap('i', '{%', '{%  %}<Esc>hhi')
