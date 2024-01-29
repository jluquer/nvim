local shell = vim.fn.has("unix") == 0 and "pwsh.exe" or vim.o.shell

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = 'VeryLazy',

  opts = function()
    local opts = {
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
    }

    local Terminal = require("toggleterm.terminal").Terminal
    function _LAZYGIT_TOGGLE()
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      lazygit:toggle()
    end

    return opts
  end,

  keys = {
    { "<C-t>", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", mode = { "n", "i", 't' }, desc = 'Toggle horizontal terminal' },
    { "<A-i>", "<cmd>ToggleTerm direction=float<CR>",              mode = { "n", "i", 't' }, desc = 'Toggle floating terminal' },
  },

  config = true,
}
