return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>o",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon open",
    },
    {
      "<leader><leader>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon open",
    },
    {
      "<leader>h",
      function()
        require("harpoon.mark").toggle_file()
      end,
      desc = "Harpoon toogle",
    },
    {
      "<leader>m",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon mark",
    },
    {
      "<leader>u",
      function()
        require("harpoon.mark").rm_file()
      end,
      desc = "Harpoon remove mark",
    },
    {
      "<leader><Tab>",
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
    require("telescope").load_extension "harpoon"
  end,
}
