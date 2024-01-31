local M = {}

setmetatable(M, {
  __index = function(t, k)
    if M[k] then
      return M[k]
    end
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

return M
