local M = {}

local Terminal = require("toggleterm.terminal").Terminal

function M.toggle_lazydocker()
  local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })
  lazydocker:toggle()
end

function M.toggle_lazygit()
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  lazygit:toggle()
end

return M
