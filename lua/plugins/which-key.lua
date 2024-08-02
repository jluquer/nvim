return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    local wk = require "which-key"
    -- document existing key chains
    wk.add {
      { "<leader>b", group = "[B]uffer" },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>f", group = "[F]ind" },
      { "<leader>g", group = "[G]it" },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      { "<leader>r", group = "[R]ename" },
      { "<leader>t", group = "[T]erminal & Tabs" },
      { "<leader>w", group = "[W]orkspace session" },
    }
  end,
  opts = {},
}
