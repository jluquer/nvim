local shell = require('utils').is_windows() and "pwsh.exe" or vim.o.shell

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = 'VeryLazy',

  opts = {
    size = 10,
    shading_factor = 2,
    direction = "float",
    shell = shell,
    float_opts = {
      border = "curved",
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },

  keys = {
    { '<C-t>',           "<CMD>ToggleTerm size=10 direction=horizontal<CR>", mode = { "n", "i", 't' }, desc = 'Toggle horizontal terminal' },
    { '<leader>t',       "<CMD>ToggleTerm size=10 direction=horizontal<CR>", mode = { "n" },           desc = 'Toggle horizontal terminal' },
    { '<A-i>',           "<cmd>ToggleTerm direction=float<CR>",              mode = { "n", "i", 't' }, desc = 'Toggle floating terminal' },
    { '<Esc><Esc><Esc>', '<C-\\><C-n>',                                      mode = 't' },
  },

  config = true,
}
