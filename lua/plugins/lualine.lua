local constants = require('config.constants')

return {
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = constants.colorscheme,
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
  },
}
