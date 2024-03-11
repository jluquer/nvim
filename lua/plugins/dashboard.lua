return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = function()
    local logo = [[
    ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
    ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
    ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
    ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
    ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local icons = require "utils.icons"
    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = require("persistence").load,
            desc = " Restore Session",
            icon = icons.ui.Retry,
            key = "s",
          },
          {
            action = "Oil",
            desc = " Explorer",
            icon = icons.ui.EmptyFolderOpen,
            key = "e",
          },
          {
            action = require("utils.telescope").find_projects,
            desc = " Recent projects",
            icon = icons.ui.Project,
            key = "p",
          },
          {
            action = "Telescope find_files",
            desc = " Find file",
            icon = icons.ui.Search,
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New file",
            icon = icons.ui.NewFile,
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent files",
            icon = icons.ui.Files,
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = " Find text",
            icon = icons.ui.FindText,
            key = "g",
          },
          {
            action = require("utils.telescope").open_config,
            desc = " Config",
            icon = icons.ui.Gear,
            key = "c",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = icons.ui.SignOut,
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
  keys = {
    { "<leader>;", ":Dashboard<cr>", desc = "Dashboard" },
  },
}
