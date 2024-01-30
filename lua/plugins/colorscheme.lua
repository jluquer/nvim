return {
  -- Theme inspired by Atom
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme(require("config.constants").colorscheme)
  end,
}
