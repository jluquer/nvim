local M = {}

M.toggleLazydocker = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })
  lazydocker:toggle()
end

return M
