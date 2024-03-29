local shell = require("utils").is_windows() and "pwsh.exe" or vim.o.shell

return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",

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
    start_in_insert = true,
  },

  keys = function()
    local toggleterm = require "toggleterm"

    local function float_term()
      toggleterm.toggle(1)
    end

    local function horizontal_term()
      toggleterm.toggle(2, nil, nil, "horizontal")
    end

    local function horizontal_right_term()
      toggleterm.toggle(3, nil, nil, "horizontal")
    end

    return {
      { "<leader>tt", float_term,            mode = { "n" },           desc = "Toggle floating terminal" },
      { "<A-i>",      float_term,            mode = { "n", "i", "t" }, desc = "Toggle floating terminal" },
      { "<A-l>",      horizontal_term,       mode = { "n", "i", "t" }, desc = "Toggle horizontal terminal" },
      { "<A-r>",      horizontal_right_term, mode = { "n", "i", "t" }, desc = "Toggle vertical terminal" },
    }
  end,

  config = true,
}
