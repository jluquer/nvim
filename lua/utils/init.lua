local M = {}

function M.is_windows()
  return vim.fn.has("unix") == 0
end

return M
