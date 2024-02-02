return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = function()
    local icons = require('utils.icons')
    vim.fn.sign_define("DiagnosticSignError",
      { text = icons.diagnostics.Error, texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
      { text = icons.diagnostics.Warning, texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
      { text = icons.diagnostics.Information, texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
      { text = icons.diagnostics.Hint, texthl = "DiagnosticSignHint" })

    return {
      close_if_last_window = true,
      popup_border_style = "rounded",
      window = {
        width = 30,
        position = 'right',
      },
      buffers = {
        follow_current_file = true,
      },

      filesystem = {
        follow_current_file = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
            ".git",
            ".vscode"
          },
          always_show = {
            '.gitignored'
          },
          never_show = {
            ".DS_Store",
            "thumbs.db"
          },
        },
      },
    }
  end,
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'File explorer' },
    { '<C-n>',     ':Neotree toggle<CR>', desc = 'File explorer', mode = { 'n', 'i', 'v' } },
  },
}
