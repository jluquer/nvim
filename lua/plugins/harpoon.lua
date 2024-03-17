return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  branch = "harpoon2",
  event = "VeryLazy",
  keys = function()
    local harpoon = require "harpoon"
    return {
      {
        "<leader>o",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon open",
      },
      {
        "<leader><leader>",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon open",
      },
      {
        "<leader>m",
        function()
          harpoon:list():append()
        end,
        desc = "Harpoon add",
      },
      {
        "<leader><Tab>",
        function()
          harpoon:list():next()
        end,
        desc = "Harpoon next file",
      },
      {
        "<leader>p",
        function()
          harpoon:list():prev()
        end,
        desc = "Harpoon prev file",
      },
    }
  end,
  config = function()
    require("telescope").load_extension "harpoon"
  end,
}
