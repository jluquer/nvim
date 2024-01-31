return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>m",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon mark",
    },
    {
      "<leader>o",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon open",
    },
    {
      "<leader>n",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Harpoon next file",
    },
    {
      "<leader>p",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Harpoon prev file",
    },
  },
  config = function()
    require("telescope").load_extension("harpoon")
  end,
}
