local M = {}

M.grep_callback = function(type)
  local mark_start
  local mark_end
  if type == 'char' then
    mark_start = vim.fn.getpos "'["
    mark_end = vim.fn.getpos "']"
  elseif type == 'v' then
    mark_start = vim.fn.getpos "'<"
    mark_end = vim.fn.getpos "'>"
  else
    print 'Invalid motion type for grep!'
    return
  end
  if mark_start[2] ~= mark_end[2] then
    print "Can't grep multiple lines!"
    return
  end
  local line = vim.fn.getline(mark_start[2])
  local text = string.sub(line, mark_start[3], mark_end[3])
  require('telescope.builtin').live_grep()
  vim.api.nvim_feedkeys(text, 'n', false)
end

M.grep = function(vtype)
  if vtype == nil then
    vim.go.operatorfunc = "v:lua.require'dzfrias.operators'.grep_callback"
    vim.api.nvim_feedkeys('g@', 'n', false)
    return
  end

  M.grep_callback(vtype)
end

return M
