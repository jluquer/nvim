local M = {}

function M.open_config()
  vim.cmd('cd ~/.config/nvim')
  require("telescope.builtin").find_files()
end

return M
