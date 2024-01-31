-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  keys = function()
    local telescope = require('telescope.builtin')
    local utils = require('utils.telescope')
    return {
      { '<leader>lg',      utils.toggle_lazygit,                 desc = 'Lazygit' },
      { '<leader>ld',      utils.toggle_lazydocker,              desc = 'Lazydocker' },
      { '<leader>sk',      telescope.keymaps,                    desc = 'Keymaps' },
      { "<leader>:",       telescope.command_history,            desc = "Command History" },
      { '<leader>sf',      utils.find_files,                     desc = 'Go to file' },
      { '<C-p>',           utils.find_files,                     desc = 'Go to file',                          mode = { 'n', 'i' } },

      -- Diagnostics
      { "<leader>dd",      utils.diagnostics_current_buffer,     desc = "Document diagnostics" },
      { "<leader>dD",      telescope.diagnostics,                desc = "Workspace diagnostics" },

      { '<leader>?',       telescope.oldfiles,                   desc = '[?] Find recently opened files' },
      { '<leader><space>', telescope.buffers,                    desc = '[ ] Find existing buffers' },
      { '<leader>/',       utils.current_buffer_fuzzy_find,      desc = '[/] Fuzzily search in current buffer' },

      { '<leader>s/',      utils.telescope_live_grep_open_files, desc = '[s]earch [/] in open files' },
      { '<leader>ss',      telescope.builtin,                    desc = '[s]earch [s]elect telescope' },
      { '<leader>gf',      telescope.git_files,                  desc = 'Search [G]it [F]iles' },
      { '<leader>sh',      telescope.help_tags,                  desc = '[S]earch [H]elp' },
      { '<leader>sw',      telescope.grep_string,                desc = '[S]earch current [W]ord' },
      { '<leader>sg',      telescope.live_grep,                  desc = '[S]earch by [G]rep' },
      { '<leader>sG',      utils.live_grep_git_root,             desc = '[S]earch by [G]rep on Git Root' },
      { '<leader>sd',      telescope.diagnostics,                desc = '[S]earch [D]iagnostics' },
      { '<leader>sr',      telescope.resume,                     desc = '[S]earch [R]esume' },
    }
  end,

  config = function()
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
  end
}
