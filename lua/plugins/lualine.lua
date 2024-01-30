local constants = require('config.constants')

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = constants.colorscheme,
      component_separators = '|',
      section_separators = '',
    },
  },
}
