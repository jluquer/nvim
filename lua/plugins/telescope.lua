-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
  },

  keys = function()
    local telescope = require "telescope.builtin"
    local utils = require "utils.telescope"
    return {
      -- LazyApps
      { "<leader>ld", utils.toggle_lazydocker,          desc = "Lazydocker" },
      { "<leader>lg", utils.toggle_lazygit,             desc = "Lazygit" },
      { "<leader>lc", utils.toggle_lazygit_nvim_config, desc = "Lazygit nvim config" },

      { "<leader>bb", telescope.buffers,                desc = "[ ] Find existing buffers" },

      -- Diagnostics
      { "<leader>dd", utils.diagnostics_current_buffer, desc = "Document diagnostics" },
      { "<leader>dw", telescope.diagnostics,            desc = "Workspace diagnostics" },

      -- Find
      {
        "<C-p>",
        telescope.find_files,
        desc = "Go to file",
        mode = { "n", "i" },
      },
      { "<leader>/",  utils.current_buffer_fuzzy_find,      desc = "[/] Search text in current buffer" },
      { "<leader>:",  telescope.command_history,            desc = "Command History" },
      { "<leader>f/", utils.telescope_live_grep_open_files, desc = "[/] in open files" },
      { "<leader>ff", telescope.find_files,                 desc = "Go to file" },
      { "<leader>fF", telescope.git_files,                  desc = "Go to [G]it [F]ile" },
      { "<leader>fk", telescope.keymaps,                    desc = "Keymaps" },
      { "<leader>ft", telescope.builtin,                    desc = "Telescope builtins" },
      { "<leader>fr", telescope.oldfiles,                   desc = "[?] Find recently opened files" },
      { "<leader>fh", telescope.help_tags,                  desc = "[H]elp" },
      { "<leader>fw", telescope.grep_string,                desc = "Find current [w]ord" },
      { "<leader>fg", telescope.live_grep,                  desc = "[G]lobal search" },
      { "<leader>fG", utils.live_grep_git_root,             desc = "[G]lobal search on Git Root" },
      { "<leader>fd", telescope.diagnostics,                desc = "Find Diagnostics" },
      { "<leader>fl", telescope.resume,                     desc = "Last search" },
      { "<leader>fp", utils.find_projects,                  desc = "Projects" },
      {
        "<leader>fc",
        function()
          telescope.find_files { cwd = vim.fn.stdpath "config" }
        end,
        desc = "Find in neovim config",
      },
    }
  end,

  config = function()
    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")

    local icons = require "utils.icons"
    local actions = require "telescope.actions"
    local utils = require "utils.telescope"

    local function filenameFirst(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail
      end
      return string.format("%s\t\t%s", tail, parent)
    end

    require("telescope").setup {
      defaults = {
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.Forward .. "  ",
        entry_prefix = "   ",
        initial_mode = "insert",
        selection_strategy = "reset",
        path_display = { "smart" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        sorting_strategy = nil,
        layout_strategy = nil,
        layout_config = {},
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          -- "--hidden",
          "--glob=!.git/",
        },

        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-t>"] = utils.select_tab,
          },
          n = {
            ["<esc>"] = actions.close,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        live_grep = {
          theme = "dropdown",
        },

        grep_string = {
          theme = "dropdown",
        },

        find_files = {
          theme = "dropdown",
          previewer = false,
          path_display = filenameFirst,
          hidden = true,
          mappings = {
            i = {
              ["<A-CR>"] = actions.select_default,
              ["<CR>"] = actions.select_tab,
            },
          },
          find_command = {
            "rg",
            "--files",
            "--glob",
            "!{.git/*,.svelte-kit/*,target/*,node_modules/*,.vscode/*}",
            "--path-separator",
            "/",
          },
          -- file_ignore_patterns = {
          --   "node_modules/",
          --   "node_modules\\",
          --   ".git/",
          --   ".git\\",
          --   ".vscode/",
          --   ".vscode\\",
          -- },
        },

        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },

        colorscheme = {
          enable_preview = true,
        },

        lsp_references = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_definitions = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_declarations = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_implementations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        projects = {
          initial_mode = "normal",
          theme = "dropdown",
        },
      },
    }
  end,
}
