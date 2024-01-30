-- [[ Basic Keymaps ]]
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
-- Keymaps for better default experience
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save or quit
map({ 'n', 'i' }, "<C-s>", "<CMD>update<CR>")

-- Lines
map("n", "<A-k>", ":m .-2<CR>")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("n", "<A-j>", ":m .+1<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Window Navigation
map({ 'n', 'i' }, "<C-h>", "<C-w>h")
map({ 'n', 'i' }, "<C-l>", "<C-w>l")
map({ 'n', 'i' }, "<C-k>", "<C-w>k")
map({ 'n', 'i' }, "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>')
