vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = '79'

-- Correct some spelling
vim.cmd [[
iabbrev <buffer> slef self
iabbrev <buffer> sefl self
]]

vim.cmd [[
" Put pprint at the top of the file
command! -buffer Pprint normal! mpggOfrom pprint import pprint<Esc>`pdmp
" Delete first line in a file
command! -buffer Dprint normal! mpggdd`pdmp
]]
