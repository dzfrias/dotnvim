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
    vim.go.operatorfunc = "v:lua.require'dzfrias.functions'.grep_callback"
    vim.api.nvim_feedkeys('g@', 'n', false)
    return
  end

  M.grep_callback(vtype)
end

M.edit_cargo = function()
  local cargo_paths = vim.fn.findfile('Cargo.toml', '.;', -1)
  if #cargo_paths == 0 then
    print 'No Cargo.toml found'
    return
  end
  if #cargo_paths == 1 then
    vim.cmd('edit ' .. cargo_paths[1])
    return
  end
  vim.ui.select(cargo_paths, { prompt = 'Select Cargo.toml' }, function(choice)
    if not choice then
      return
    end
    vim.cmd('edit ' .. choice)
  end)
end

return M
