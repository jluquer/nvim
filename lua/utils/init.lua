local M = {}

M.openConfig = function()
  os.execute('cd ~/.config/nvim')
  require("telescope.builtin").find_files()
end

return M
