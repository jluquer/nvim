local M = {}

M.openConfig = function()
  os.execute('cd $HOME/.config/nvim')
  require("telescope.builtin").find_files()
end

return M
