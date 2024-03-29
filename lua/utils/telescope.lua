local M = {}

local telescope = require "telescope.builtin"
local Terminal = require("toggleterm.terminal").Terminal

function M.toggle_lazydocker()
  local lazydocker = Terminal:new { cmd = "lazydocker", hidden = true, count = 4, direction = "float" }
  lazydocker:toggle()
end

function M.toggle_lazygit()
  local lazygit = Terminal:new { cmd = "lazygit", dir = "git_dir", hidden = true, count = 4, direction = "float" }
  lazygit:toggle()
end

function M.toggle_lazygit_nvim_config()
  local lazygit =
      Terminal:new { cmd = "lazygit", dir = vim.fn.stdpath "config", hidden = true, count = 4, direction = "float" }
  lazygit:toggle()
end

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
function M.find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print "Not a git repository. Searching on current working directory"
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
function M.live_grep_git_root()
  local git_root = M.find_git_root()
  if git_root then
    telescope.live_grep {
      search_dirs = { git_root },
    }
  end
end

function M.telescope_live_grep_open_files()
  telescope.live_grep {
    grep_open_files = true,
    prompt_title = "Search text in Open Files",
  }
end

function M.current_buffer_fuzzy_find()
  telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

function M.open_config()
  local config_path = require("utils").is_windows() and "~/AppData/Local/nvim/" or "~/.config/nvim"
  vim.cmd("cd " .. config_path)
  require("oil").open(config_path)
end

function M.find_projects()
  local extensions = require("telescope").extensions
  extensions.projects.projects(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

function M.select_tab(bufnr)
  require("telescope.actions.set").edit(bufnr, "tab drop")
end

function M.diagnostics_current_buffer()
  telescope.diagnostics { bufnr = 0 }
end

return M
