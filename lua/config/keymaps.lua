-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set
local lazyterm = function()
  ---@diagnostic disable-next-line: redundant-parameter
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
map("n", "<A-i>", lazyterm, { desc = "Terminal (Root Dir)" })
map("t", "<A-i>", "<cmd>close<cr>", { desc = "Hide Terminal" })
