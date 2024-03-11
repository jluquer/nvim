return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = { options = vim.opt.sessionoptions:get() },
  keys = {
    {
      "<leader>ws",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>wl",
      function()
        require("persistence").load { last = true }
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>wd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
